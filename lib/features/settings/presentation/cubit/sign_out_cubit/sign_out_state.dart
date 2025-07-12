import 'package:equatable/equatable.dart';

abstract class SignOutState extends Equatable {
  const SignOutState();

  @override
  List<Object> get props => [];
}
class SignOutInitialState extends SignOutState{}
class SignOutLoadingState extends SignOutState{}
class SignOutSuccessState extends SignOutState{}

class SignOutFailureState extends SignOutState{
    final String message;

 const SignOutFailureState({required this.message});
}
