import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zoom_clone/core/resources/firebase_failure.dart';
import 'package:zoom_clone/core/resources/firebase_methods.dart';
import 'package:zoom_clone/core/resources/methods.dart';
import 'package:zoom_clone/features/settings/data/repos/settings_repo.dart';

class SettingsRepoImpl implements SettingsRepo {
  @override
  Future<Either<FirebaseFailure, Map<String, dynamic>>> getUserData(
      String collectionName) async {
    final String uid = FirebaseHelper.currentUser?.uid ?? "";
    try {
      final user = await FirebaseHelper.getDocumentById(
        collectionPath: collectionName,
        docId: uid,
      );

      if (user == null) {
        return Left(FirebaseFailure(
            message: 'User document does not exist.', code: 'not-found'));
      }

      return Right(user); // ✅ هنا هترجع الـ Map
    } catch (e) {
      return Left(FirebaseFailure.fromFirebaseException(
          e is Exception ? e : Exception(e.toString())));
    }
  }

  @override
  Future<Either<FirebaseFailure, void>> signOut() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        return Left(FirebaseFailure(
            message: 'No user is currently signed in.', code: 'no-user'));
      }

      final providers = user.providerData.map((e) => e.providerId).toList();

      if (providers.contains('google.com')) {
        await FirebaseHelper.signOutGoogle();
        print("Sign out from Google");
      } else {
        await FirebaseHelper.signOut(); // ده Sign out عام من FirebaseAuth
        print("Sign out from Firebase");
      }

      return const Right(null);
    } catch (e) {
      return Left(FirebaseFailure.fromFirebaseException(
          e is Exception ? e : Exception(e.toString())));
    }
  }
}
