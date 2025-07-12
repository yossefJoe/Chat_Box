import 'package:equatable/equatable.dart';

abstract class UserDataState extends Equatable {
  const UserDataState();

  @override
  List<Object> get props => [];
}
class UserDataInitialState extends UserDataState{}
class UserDataLoadingState extends UserDataState{}
class UserDataSuccessState extends UserDataState{
  final Map<String,dynamic> userData;

 const UserDataSuccessState({required this.userData});
}

class UserDataFailureState extends UserDataState{
    final String message;

 const UserDataFailureState({required this.message});
}
