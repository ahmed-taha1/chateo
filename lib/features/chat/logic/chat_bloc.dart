import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../../core/models/message.dart';
import '../../../features/chat/data/chat_repo.dart';

import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final String phoneNumber;
  final ChatRepo chatRepo;
  late String chatId;
  StreamSubscription<List<Message>>? _messageSubscription;

  ChatBloc(this.phoneNumber, this.chatRepo) : super(ChatInitial()) {
    on<FetchChat>(onFetchChat);
    on<NewMessageReceived>(onNewMessageReceived);
    on<SendMessage>(onSendMessage);
  }

  Future<void> onFetchChat(FetchChat event, Emitter<ChatState> emit) async {
    await _messageSubscription?.cancel();
    emit(ChatLoading());
    try {
      chatId = event.chatId;
      _messageSubscription = chatRepo.fetchChatMessages(event.chatId).listen(
        (messages) {
          add(NewMessageReceived(messages: messages));
        },
        onError: (error) {
          emit(ChatError('Failed to fetch chat: $error'));
        },
        cancelOnError: true,
      );
    } catch (e) {
      emit(ChatError('Failed to fetch chat: $e'));
    }
  }

  void onNewMessageReceived(NewMessageReceived event, Emitter<ChatState> emit) {
    emit(ChatFetched(event.messages));
  }

  Future<void> onSendMessage(SendMessage event, Emitter<ChatState> emit) async {
    try {
      await chatRepo.sendMessage(chatId, event.message);
    } catch (e) {
      emit(ChatError('Failed to send message: $e'));
    }
  }

  @override
  Future<void> close() async {
    await _messageSubscription?.cancel();
    return super.close();
  }
}
