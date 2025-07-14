import 'package:equatable/equatable.dart';

abstract class UserContactsState extends Equatable {
  const UserContactsState();

  @override
  List<Object> get props => [];
}
class UserContactsInitialState extends UserContactsState{}
class UserContactsLoadingState extends UserContactsState{}
class UserContactsSuccessState extends UserContactsState{
  final List<Map<String,dynamic>> userContacts;

 const UserContactsSuccessState({required this.userContacts});
}

class UserContactsFailureState extends UserContactsState{
    final String message;

 const UserContactsFailureState({required this.message});
}
