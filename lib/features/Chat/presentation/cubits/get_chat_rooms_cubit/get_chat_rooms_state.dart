import 'package:equatable/equatable.dart';
import 'package:zoom_clone/features/Chat/data/models/chat_room_model.dart';

abstract class GetChatRoomsState extends Equatable {
  @override
  List<Object?> get props => [];
}
class GetChatRoomsInitialState extends GetChatRoomsState{}
class GetChatRoomsLoadingState extends GetChatRoomsState{}
class GetChatRoomsSuccessState extends GetChatRoomsState {
  final List<ChatRoom> chatRooms;
  final DateTime updatedAt;  // ✅ Force uniqueness

  GetChatRoomsSuccessState({
    required this.chatRooms,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now();

  @override
  List<Object?> get props => [chatRooms, updatedAt];
}

class GetChatRoomsFailureState extends GetChatRoomsState{
    final String message;

 GetChatRoomsFailureState({
    required this.message,
  }) ;

  @override
  List<Object?> get props => [message];}
