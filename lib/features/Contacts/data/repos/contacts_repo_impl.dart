import 'package:dartz/dartz.dart';
import 'package:zoom_clone/core/resources/firebase_failure.dart';
import 'package:zoom_clone/core/resources/firebase_methods.dart';
import 'package:zoom_clone/features/Contacts/data/repos/contacts_repo.dart';

class ContactsRepoImpl extends ContactsRepo{
  @override
  Future<Either<FirebaseFailure, List<Map<String, dynamic>>>> getContacts(String collectionName) async {
     final String uid = FirebaseHelper.currentUser?.uid ?? "";
    try {
      final user = await FirebaseHelper.fetchAllExceptUid(
        collectionPath: collectionName,
        uidField: "uid",
        excludedUid: uid,
      );

      if (user.isEmpty) {
        return Left(FirebaseFailure(
            message: 'No contacts found.', code: 'not-found'));
      }

      return Right(user); // ✅ هنا هترجع الـ Map
    } catch (e) {
      return Left(FirebaseFailure.fromFirebaseException(
          e is Exception ? e : Exception(e.toString())));
    }
  }

}