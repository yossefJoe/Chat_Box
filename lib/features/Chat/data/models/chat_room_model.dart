import 'package:zoom_clone/features/Chat/data/models/chat_message_model.dart';

class ChatRoom {
  final String chatRoomId;
  final String otherUserId;
  final DateTime createdAt;
  final String? imageUrl;
  final String userName;
  final bool? active;
  final List<ChatMessage> messages;

  ChatRoom( {
    required this.chatRoomId,
    required this.otherUserId,
    required this.createdAt,
    this.imageUrl,required this.userName, this.active = false,
    this.messages = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'chatRoomId': chatRoomId,
      'otherUserId': otherUserId,
      'imageUrl': imageUrl,
      'userName': userName,
      'active': active,
      'createdAt': createdAt.toIso8601String(),
      'messages': messages.map((msg) => msg.toMap()).toList(),
    };
  }

  factory ChatRoom.fromMap(Map<String, dynamic> map) {
    return ChatRoom(
      chatRoomId: map['chatRoomId'],
      otherUserId: map['otherUserId'],
      imageUrl: map['imageUrl'],
      userName: map['userName'],
      active: map['active'],
      createdAt: DateTime.parse(map['createdAt']),
      messages: (map['messages'] as List<dynamic>? ?? [])
          .map((e) => ChatMessage.fromMap(e))
          .toList(),
    );
  }
}
