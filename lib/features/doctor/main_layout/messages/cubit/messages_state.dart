import '../data/message_model.dart';

abstract class MessagesState {}

class MessagesInitial extends MessagesState {}

class MessagesLoading extends MessagesState {}

class MessagesSuccess extends MessagesState {
  final List<MessageModel> messages;

  MessagesSuccess(this.messages);
}

class MessagesError extends MessagesState {
  final String error;

  MessagesError(this.error);
}
