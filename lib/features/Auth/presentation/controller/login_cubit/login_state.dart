import 'package:equatable/equatable.dart';

abstract class LogInState extends Equatable {
  const LogInState();

  @override
  List<Object> get props => [];
}
class LoginInitialState extends LogInState{}
class LoginLoadingState extends LogInState{}
class LoginSuccessState extends LogInState{}

class LoginFailureState extends LogInState{
    final String message;

 const LoginFailureState({required this.message});
}
