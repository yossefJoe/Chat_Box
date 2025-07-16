import 'package:equatable/equatable.dart';
import 'package:zoom_clone/features/Chat/data/models/chat_message_model.dart';
import 'package:zoom_clone/features/Chat/data/models/chat_room_model.dart';

abstract class GetChatMessagesState extends Equatable {
  const GetChatMessagesState();

  @override
  List<Object> get props => [];
}
class GetChatMessagesInitialState extends GetChatMessagesState{}
class GetChatMessagesLoadingState extends GetChatMessagesState{}
class GetChatMessagesSuccessState extends GetChatMessagesState{
  final List<ChatMessage> chatMessages;

 const GetChatMessagesSuccessState({required this.chatMessages});
}

class GetChatMessagesFailureState extends GetChatMessagesState{
    final String message;

 const GetChatMessagesFailureState({required this.message});
}
