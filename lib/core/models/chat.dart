import 'message.dart';

class Chat{
  late String title;
  late String id;
  late List<Message> messages;

  Chat({required this.title, required this.id, required this.messages});
}