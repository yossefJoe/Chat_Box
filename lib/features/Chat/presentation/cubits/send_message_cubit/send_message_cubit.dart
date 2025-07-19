import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_clone/features/Chat/data/models/chat_message_model.dart';
import 'package:zoom_clone/features/Chat/data/models/chat_room_model.dart';
import 'package:zoom_clone/features/Chat/data/repos/chat_repo_impl.dart';
import 'package:zoom_clone/features/Chat/presentation/cubits/send_message_cubit/send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  final ChatRepoImpl chatRepoImpl;

  SendMessageCubit(this.chatRepoImpl) : super(SendMessageInitialState());

  Future<void> sendMessage(String otherUid, ChatMessage message, ChatRoom chatRoom, ChatRoom otherUserChatRoom) async {
    emit(SendMessageLoadingState());

    final result = await chatRepoImpl.sendMessage(
        otherUid,message,chatRoom,otherUserChatRoom
    );

    result.fold(
      (failure) => emit(SendMessageFailureState(message: failure.message)),
      (_) => emit(SendMessageSuccessState()),
    );
  }
}
