import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_clone/core/resources/firebase_failure.dart';
import 'package:zoom_clone/features/Chat/data/models/chat_room_model.dart';
import 'package:zoom_clone/features/Chat/data/repos/chat_repo.dart';
import 'get_chat_rooms_state.dart';

class GetChatRoomsCubit extends Cubit<GetChatRoomsState> {
  final ChatRepo chatRepo;
  StreamSubscription<List<ChatRoom>>? _chatRoomsSubscription;

  GetChatRoomsCubit(this.chatRepo) : super(GetChatRoomsInitialState());

  void fetchChatRooms() async {
    emit(GetChatRoomsLoadingState());

    final result = await chatRepo.getChatRoomsStream();
    result.fold(
      (failure) => emit(GetChatRoomsFailureState(message: failure.message)),
      (chatRoomsStream) async {
        await _chatRoomsSubscription?.cancel(); // Cancel any previous stream

        _chatRoomsSubscription = chatRoomsStream.listen(
          (chatRooms) {
            print("Cubit emitting new chatRooms with message counts");
            emit(GetChatRoomsSuccessState(
              chatRooms: List.from(chatRooms),
              updatedAt: DateTime.now(), // ✅ Unique each time
            ));
          },
          onError: (error) {
            emit(GetChatRoomsFailureState(
              message: FirebaseFailure.fromFirebaseException(error).message,
            ));
          },
        );
      },
    );
  }

  @override
  Future<void> close() {
    _chatRoomsSubscription?.cancel();
    return super.close();
  }
}
