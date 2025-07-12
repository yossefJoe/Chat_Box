import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zoom_clone/core/resources/firebase_failure.dart';
import 'package:zoom_clone/core/resources/firebase_methods.dart';
import 'package:zoom_clone/features/Auth/data/models/signup_params_model.dart';
import 'package:zoom_clone/features/Auth/data/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  @override
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    // TODO: implement signUpWithEmailAndPassword
  }
@override
Future<Either<FirebaseFailure, void>> signInWithEmailAndPassword({
  required SignupParamsModel signupParamsModel
}) async {
  try {
    final user = await FirebaseHelper.signInWithEmail(email: signupParamsModel.email!, password: signupParamsModel.password!);

    if (user != null) {
      return const Right(null);
    } else {
      // Fallback error when no user is returned but no exception is thrown
      return Left(FirebaseFailure(
        message: 'Login failed. Please check your credentials and try again.',
        code: 'null-user',
      ));
    }
  } catch (e) {
    return Left(FirebaseFailure.fromFirebaseAuthException(e is Exception ? e : Exception(e.toString())));
  }
}



  @override
  Future<void> signInWithGoogle() async {
    // TODO: implement signInWithGoogle
  }

 

  
}