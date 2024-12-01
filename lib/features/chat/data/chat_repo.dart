import 'package:firebase_database/firebase_database.dart';
import '../../../core/models/message.dart';

class ChatRepo {
  final FirebaseDatabase firebaseDatabase;

  ChatRepo(this.firebaseDatabase);

  Stream<List<Message>> fetchChatMessages(String chatId) {
    final ref = firebaseDatabase.ref('chats/$chatId/msg');
    return ref.onValue.map(
          (event) {
        final data = event.snapshot.value as Map<dynamic, dynamic>?;

        if (data != null) {
          final messages = data.entries.map((entry) {
            final messageData = entry.value as Map<dynamic, dynamic>;
            return Message(
              sender: messageData['sender'],
              message: messageData['message'],
              timestamp: messageData['timestamp'] ?? DateTime.now().millisecondsSinceEpoch,
            );
          }).toList();

          // Sort messages in descending order (newest first)
          messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
          return messages;
        }
        return [];
      },
    );
  }


  Future<void> sendMessage(String chatId, Message message) async {
    final ref = firebaseDatabase.ref('chats/$chatId/msg');
    await ref.push().set({
      'sender': message.sender,
      'message': message.message,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }
}
