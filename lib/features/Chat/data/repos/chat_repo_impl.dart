import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:dartz/dartz.dart';
import 'package:zoom_clone/core/resources/firebase_failure.dart';
import 'package:zoom_clone/core/resources/firebase_methods.dart';
import 'package:zoom_clone/core/resources/methods.dart';
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

  @override
  Future<Either<FirebaseFailure, void>> createChatRoomIfNotExists(
      String myUid, String otherUid, ChatRoom chatRoom) async {
    try {
      final chatRoomRef = FirebaseFirestore.instance
          .collection('chats')
          .doc(myUid)
          .collection('chatrooms')
          .doc(otherUid);

      final chatRoomSnapshot = await chatRoomRef.get();

      if (!chatRoomSnapshot.exists) {
        await chatRoomRef.set(chatRoom.toMap());
      }
      return Right(null);
    } catch (e) {
      return Left(FirebaseFailure.fromFirebaseException(
          e is Exception ? e : Exception(e.toString())));
    }
  }

  @override
  Future<Either<FirebaseFailure, void>> sendMessage(
      String otherUid,
      ChatMessage message,
      ChatRoom myChatRoom,
      ChatRoom otherUserChatRoom) async {
    String myUid = FirebaseHelper.currentUser!.uid;
    try {
      await createChatRoomIfNotExists(myUid, otherUid, myChatRoom);
      await createChatRoomIfNotExists(
          otherUid, myUid, otherUserChatRoom); // Create for the other user too

      final myChatRoomRef = FirebaseFirestore.instance
          .collection('chats')
          .doc(myUid)
          .collection('chatrooms')
          .doc(otherUid);

      final otherChatRoomRef = FirebaseFirestore.instance
          .collection('chats')
          .doc(otherUid)
          .collection('chatrooms')
          .doc(myUid);

      // Update sender's chatroom
      await myChatRoomRef.update({
        'messages': FieldValue.arrayUnion([message.toMap()])
      });

      // Update receiver's chatroom
      await otherChatRoomRef.update({
        'messages':
            FieldValue.arrayUnion([message.copyWith(isFromMe: false).toMap()])
      });
      return Right(null);
    } catch (e) {
      return Left(FirebaseFailure.fromFirebaseException(
          e is Exception ? e : Exception(e.toString())));
    }
  }

  @override
  Future<Either<Exception, List<Contact>>> getMyContacts() async {
    try {
      final contacts = await Methods.getContacts();
      return Right(contacts);
    } catch (e) {
      return Left(e is Exception ? e : Exception(e.toString()));
    }
  }

 
}
