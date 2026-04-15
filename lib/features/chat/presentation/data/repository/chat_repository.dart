import 'package:dio/dio.dart';

import '../../../../../core/network/api_constants.dart';
import '../models/conversation_model.dart';
import '../models/message_model.dart';

class ChatRepository {
  final Dio dio;

  ChatRepository(this.dio);

  Future<List<Conversation>> getConversations() async {
    final res = await dio.get(ApiConstants.getConversations);
    return (res.data['data'] as List)
        .map((e) => Conversation.fromJson(e))
        .toList();
  }

  Future<String> createConversation(int targetUserId) async {
    final res = await dio.post(
      ApiConstants.getConversations,
      data: {"targetUserId": targetUserId},
    );
    return res.data['data']['id'];
  }

  Future<List<Message>> getMessages(String conversationId) async {
    final res = await dio.get(ApiConstants.getChatMessages(conversationId));

    final list = (res.data['data'] as List)
        .map((e) => Message.fromJson(e))
        .toList();

    list.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    return list;
  }
}