import 'package:dio/dio.dart';
import '../../../../../core/network/api_constants.dart';
import 'message_model.dart';

class MessagesRepository {
  final Dio dio;

  MessagesRepository(this.dio);

  Future<List<MessageModel>> getMessages() async {
    final response = await dio.get(ApiConstants.messages);

    List data = response.data["messages"];
    return data.map((e) => MessageModel.fromJson(e)).toList();
  }
}
