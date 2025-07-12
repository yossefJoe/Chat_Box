import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFailure {
  final String message;
  final String? code;

  FirebaseFailure({required this.message, this.code});

  /// Handles FirebaseAuthException
  factory FirebaseFailure.fromFirebaseAuthException(Exception e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'invalid-email':
          return FirebaseFailure(message: 'The email address is badly formatted.', code: e.code);
        case 'user-disabled':
          return FirebaseFailure(message: 'This user has been disabled.', code: e.code);
        case 'user-not-found':
          return FirebaseFailure(message: 'No user found with this email.', code: e.code);
        case 'wrong-password':
          return FirebaseFailure(message: 'Incorrect password.', code: e.code);
        default:
          return FirebaseFailure(message: e.message ?? 'Unknown Firebase Auth error.', code: e.code);
      }
    }

    return FirebaseFailure(message: 'Unexpected error: ${e.toString()}', code: 'unexpected');
  }

  /// Handles Firestore (and general Firebase) exceptions
  factory FirebaseFailure.fromFirebaseException(Exception e) {
    if (e is FirebaseException) {
      switch (e.code) {
        case 'not-found':
          return FirebaseFailure(message: 'The requested document or collection was not found.', code: e.code);
        case 'permission-denied':
          return FirebaseFailure(message: 'You do not have permission to access this data.', code: e.code);
        case 'unavailable':
          return FirebaseFailure(message: 'The service is currently unavailable. Please try again later.', code: e.code);
        case 'cancelled':
          return FirebaseFailure(message: 'The request was cancelled.', code: e.code);
        case 'data-loss':
          return FirebaseFailure(message: 'Data loss occurred.', code: e.code);
        case 'deadline-exceeded':
          return FirebaseFailure(message: 'The request took too long. Try again.', code: e.code);
        default:
          return FirebaseFailure(message: e.message ?? 'An unknown Firebase error occurred.', code: e.code);
      }
    }

    return FirebaseFailure(message: 'Unexpected error: ${e.toString()}', code: 'unexpected');
  }

  @override
  String toString() => 'FirebaseFailure(code: $code, message: $message)';
}
