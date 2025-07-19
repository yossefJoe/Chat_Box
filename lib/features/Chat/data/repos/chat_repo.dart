import 'package:contacts_service/contacts_service.dart';
import 'package:dartz/dartz.dart';
import 'package:zoom_clone/core/resources/firebase_failure.dart';
import 'package:zoom_clone/features/Chat/data/models/chat_message_model.dart';
import 'package:zoom_clone/features/Chat/data/models/chat_room_model.dart';

abstract class ChatRepo {
  Future<Either<FirebaseFailure, Stream<List<ChatRoom>>>> getChatRoomsStream();
  Future<Either<FirebaseFailure, Stream<List<ChatMessage>>>> getChatMessagesStream(String otherUid);
  Future<Either<Exception, List<Contact>>> getMyContacts();
  Future<Either<FirebaseFailure, void>> sendMessage(  String otherUid, ChatMessage message, ChatRoom myChatRoom, ChatRoom otherUserChatRoom);
  Future<Either<FirebaseFailure, void>> createChatRoomIfNotExists(String myUid, String otherUid,ChatRoom chatRoom);
  
}