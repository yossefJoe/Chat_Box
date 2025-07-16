import 'package:dartz/dartz.dart';
import 'package:zoom_clone/core/resources/firebase_failure.dart';
import 'package:zoom_clone/features/Chat/data/models/chat_message_model.dart';
import 'package:zoom_clone/features/Chat/data/models/chat_room_model.dart';

abstract class ChatRepo {
  Future<Either<FirebaseFailure, Stream<List<ChatRoom>>>> getChatRoomsStream();
  Future<Either<FirebaseFailure, Stream<List<ChatMessage>>>> getChatMessagesStream(String otherUid);
}