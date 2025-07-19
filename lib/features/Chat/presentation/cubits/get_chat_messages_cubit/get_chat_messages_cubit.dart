import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_clone/core/resources/firebase_failure.dart';
import 'package:zoom_clone/features/Chat/data/models/chat_message_model.dart';
import 'package:zoom_clone/features/Chat/data/repos/chat_repo_impl.dart';
import 'package:zoom_clone/features/Chat/presentation/cubits/get_chat_messages_cubit/get_chat_messages_state.dart';

class GetChatMessagesCubit extends Cubit<GetChatMessagesState> {
  final ChatRepoImpl chatRepo;
  StreamSubscription<List<ChatMessage>>? _chatMessagesSubscription;
  
  final List<ChatMessage> _messages = [];

  GetChatMessagesCubit(this.chatRepo) : super(GetChatMessagesInitialState());

  void fetchChatMessages(String otherUid) async {
    emit(GetChatMessagesLoadingState());

    final result = await chatRepo.getChatMessagesStream(otherUid);
    result.fold(
      (failure) => emit(GetChatMessagesFailureState(message: failure.message)),
      (chatMessagesStream) async {
        await _chatMessagesSubscription?.cancel();

        _chatMessagesSubscription = chatMessagesStream.listen(
          (chatMessages) {
            _messages
              ..clear()
              ..addAll(chatMessages)
              ..sort((a, b) => a.time.compareTo(b.time));

            emit(GetChatMessagesSuccessState(
              chatMessages: List.from(_messages),
            ));
          },
          onError: (error) {
            emit(GetChatMessagesFailureState(
              message: FirebaseFailure.fromFirebaseException(error).message,
            ));
          },
        );
      },
    );
  }

  void addMessage(ChatMessage message) {
    print("Adding new message: ${message.message ?? 'Voice'}");
    _messages.add(message);
    _messages.sort((a, b) => a.time.compareTo(b.time));
    emit(GetChatMessagesSuccessState(chatMessages: List.from(_messages)));
  }

  List<ChatMessage> get messages => _messages;

  @override
  Future<void> close() {
    _chatMessagesSubscription?.cancel();
    return super.close();
  }
}
