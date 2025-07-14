import 'package:dartz/dartz.dart';
import 'package:zoom_clone/core/resources/firebase_failure.dart';

abstract class ContactsRepo {
  Future< Either<FirebaseFailure, List<Map<String, dynamic>>>> getContacts(String collectionName);
}