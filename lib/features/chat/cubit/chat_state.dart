import '../presentation/data/models/conversation_model.dart';
import '../presentation/data/models/message_model.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatUpdated extends ChatState {
  final List<Message> messages;
  ChatUpdated(this.messages);
}

class ChatConversationsLoaded extends ChatState {
  final List<Conversation> conversations;
  ChatConversationsLoaded(this.conversations);
}

class ChatTypingState extends ChatState {
  final bool isTyping;
  ChatTypingState(this.isTyping);
}

class ChatOnlineState extends ChatState {
  final List<String> onlineUsers;
  ChatOnlineState(this.onlineUsers);
}

class ChatError extends ChatState {
  final String message;
  ChatError(this.message);
}

class ChatMessageSent extends ChatState {}