import 'package:chateo/core/models/message.dart';

import 'chat.dart';

class Community{
  String id;
  // Chat messages;
  String name;
  String description;
  String image;
  bool isSubscribed;
  Community({
    required this.id,
    // required this.messages,
    required this.name,
    required this.description,
    required this.image,
    required this.isSubscribed,
  });

  factory Community.fromJson(Map<String, dynamic> json, String id, {bool isSubscribed = false}) {
    return Community(
      id: id,
      name: json['name'],
      description: json['description'],
      image: json['image'],
      isSubscribed: isSubscribed,
    );
  }
}