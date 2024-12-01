class Message{
  final String message;
  final String sender;
  final int timestamp;


  Message({
    required this.message,
    required this.sender,
    int? timestamp,
  }) : timestamp = timestamp ?? DateTime.now().millisecondsSinceEpoch;
}