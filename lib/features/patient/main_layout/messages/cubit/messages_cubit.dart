import 'package:flutter_bloc/flutter_bloc.dart';
import 'messages_state.dart';
import '../data/messages_repository.dart';

class MessagesCubit extends Cubit<MessagesState> {
  final MessagesRepository repository;

  MessagesCubit(this.repository) : super(MessagesInitial());

  Future<void> fetchMessages() async {
    emit(MessagesLoading());
    try {
      final messages = await repository.getMessages();
      emit(MessagesSuccess(messages));
    } catch (e) {
      emit(MessagesError(e.toString()));
    }
  }
}
