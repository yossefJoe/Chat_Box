import 'package:dartz/dartz.dart';
import 'package:zoom_clone/core/resources/firebase_failure.dart';
import 'package:zoom_clone/core/resources/firebase_methods.dart';
import 'package:zoom_clone/features/Chat/data/models/chat_message_model.dart';
import 'package:zoom_clone/features/Chat/data/models/chat_room_model.dart';
import 'package:zoom_clone/features/Chat/data/repos/chat_repo.dart';

class ChatRepoImpl extends ChatRepo {
  @override
  Future<Either<FirebaseFailure, Stream<List<ChatRoom>>>>
      getChatRoomsStream() async {
    final String uid = FirebaseHelper.currentUser?.uid ?? "";
    try {
      final chatRooms = FirebaseHelper.getChatRoomsStream(uid);
      return Right(chatRooms);
    } catch (e) {
      return Left(FirebaseFailure.fromFirebaseException(
          e is Exception ? e : Exception(e.toString())));
    }
  }

  @override
  Future<Either<FirebaseFailure, Stream<List<ChatMessage>>>>
      getChatMessagesStream(String otherUid) async {
    final String uid = FirebaseHelper.currentUser?.uid ?? "";
    try {
      final chatRooms = FirebaseHelper.getMessagesStream(uid, otherUid);
      return Right(chatRooms);
    } catch (e) {
      return Left(FirebaseFailure.fromFirebaseException(
          e is Exception ? e : Exception(e.toString())));
    }
  }
}
