import '../../../core/models/message.dart';

abstract class ChatEvent {}

class FetchChat extends ChatEvent {
  final String chatId;
  FetchChat(this.chatId);
}

class NewMessageReceived extends ChatEvent {
  final List<Message> messages;
  NewMessageReceived({required this.messages});
}

class SendMessage extends ChatEvent {
  final Message message;
  SendMessage(this.message);
}