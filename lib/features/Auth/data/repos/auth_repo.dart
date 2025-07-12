import 'package:dartz/dartz.dart';
import 'package:zoom_clone/core/resources/firebase_failure.dart';
import 'package:zoom_clone/features/Auth/data/models/signup_params_model.dart';

abstract class AuthRepo {
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });

  Future<Either<FirebaseFailure, void>> signInWithEmailAndPassword({
    required SignupParamsModel signupParamsModel,
  });

  Future<void> signInWithGoogle();


}