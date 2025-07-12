import 'package:dartz/dartz.dart';
import 'package:zoom_clone/core/resources/firebase_failure.dart';

abstract class SettingsRepo {
  Future<Either<FirebaseFailure, Map<String, dynamic>>> getUserData(
      String collectionName);
  Future<Either<FirebaseFailure, void>> signOut();
}
