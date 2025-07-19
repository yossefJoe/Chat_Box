import 'package:equatable/equatable.dart';
import 'package:zoom_clone/features/Chat/data/models/chat_message_model.dart';

abstract class SendMessageState extends Equatable {
  const SendMessageState();

  @override
  List<Object> get props => [];
}
class SendMessageInitialState extends SendMessageState{}
class SendMessageLoadingState extends SendMessageState{}
class SendMessageSuccessState extends SendMessageState{
}

class SendMessageFailureState extends SendMessageState{
    final String message;

 const SendMessageFailureState({required this.message});
}
