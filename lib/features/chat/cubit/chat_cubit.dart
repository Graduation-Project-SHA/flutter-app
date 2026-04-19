import 'dart:async';
import 'package:bloc/bloc.dart';
import '../presentation/data/models/conversation_model.dart';
import '../presentation/data/models/message_model.dart';
import '../presentation/data/repository/chat_repository.dart';
import '../services/socket_service.dart';
import 'chat_state.dart';
class ChatCubit extends Cubit<ChatState> {
  final SocketService socketService;
  final ChatRepository repository;

  String? currentConversationId;
  String? currentUserId;

  ChatCubit(this.socketService, this.repository) : super(ChatInitial()) {
    socketService.onEventReceived = (event, data) => _handleSocketEvent(event, data);
  }

  List<Message> messages = [];
  List<Conversation> conversations = [];
  List<String> onlineUsers = [];

  void initSocket() {
    if (!socketService.isConnected) {
      socketService.connect();
    }
  }

  void _handleSocketEvent(String event, dynamic data) {
    if (event == "socket_ready") {
      if (currentConversationId != null && currentConversationId!.isNotEmpty) {
        _sendJoinAndSeen();
      }
      return;
    }

    switch (event) {
      case "join_chat_success":
        print("Joined chat successfully");
        break;

      case "receive_message":
        final msg = Message.fromJson(data);

        messages.removeWhere((m) => m.id.startsWith("temp_") && m.text == msg.text);

        if (!messages.any((m) => m.id == msg.id)) {
          messages.add(msg);
          messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
          emit(ChatUpdated(List.from(messages)));
        }
        break;

      case "message_sent":
        print("Server confirmed: Message Sent");
        break;


      case "update_inbox":
        print("📥 New Message Received! Refreshing Inbox...");
        loadConversations();
        break;

    }
  }

  void _sendJoinAndSeen() {
    if (currentConversationId != null && socketService.isConnected) {
      socketService.sendMessage(
        event: "join_chat",
        data: {"conversationId": currentConversationId},
      );
    }
  }




  Future<void> loadConversations() async {
    emit(ChatLoading());


    socketService.connect();

    try {
      conversations = await repository.getConversations();
      emit(ChatConversationsLoaded(conversations));
      for (var conv in conversations) {
        socketService.sendMessage(
          event: "join_chat",
          data: {"conversationId": conv.id},
        );
      }
    } catch (e) {
      print("Error loading conversations: $e");
    }
  }


  void loadMessages(String conversationId, String userId, {String? targetUserId}) async {
    currentConversationId = conversationId;
    currentUserId = userId;

    if (!socketService.isConnected) {
      socketService.connect();
    }

    if (conversationId.isEmpty && targetUserId != null) {
      try {
        final existingConv = conversations.firstWhere(
              (conv) => conv.targetUserId == targetUserId,
        );
        conversationId = existingConv.id;
        currentConversationId = conversationId;
      } catch (e) {
        print("No existing conversation found for this doctor.");
      }
    }

    if (conversationId.isEmpty) {
      messages = [];
      emit(ChatUpdated([]));
      return;
    }

    try {
      messages = await repository.getMessages(conversationId);
      messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      emit(ChatUpdated(List.from(messages)));

      if (socketService.isConnected) {
        _sendJoinAndSeen();
      }
    } catch (e) {
      print("Error loading messages: $e");
      emit(ChatError("فشل تحميل الرسائل"));
    }
  }

  Future<void> sendMessage({
    required String conversationId,
    required String senderId,
    required String targetUserId,
    required String text,
  }) async {
    try {
      String convId = conversationId;

      if (convId.isEmpty) {
        convId =
        await repository.createConversation(int.parse(targetUserId));
        currentConversationId = convId;
      }

      final tempMsg = Message(
          id: "temp_${DateTime.now().millisecondsSinceEpoch}",
          senderId: senderId,
          text: text,
          conversationId: convId,
          createdAt: DateTime.now()
      );

      messages.add(tempMsg);
      emit(ChatUpdated(List.from(messages)));

      socketService.sendMessage(
        event: "send_message",
        data: {
          "conversationId": convId,
          "senderId": int.tryParse(senderId) ?? senderId,
          "targetUserId":
          int.tryParse(targetUserId) ?? targetUserId,
          "text": text,
        },
      );

    } catch (e) {
      print("Error sending: $e");
    }
  }


  void sendTyping(String conversationId) {
    if (conversationId.isNotEmpty) {
      socketService.sendMessage(
        event: "typing",
        data: {"conversationId": conversationId},
      );
    }
  }
}