import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';

abstract class GetMyContactsState extends Equatable {
  const GetMyContactsState();

  @override
  List<Object> get props => [];
}
class GetMyContactsInitialState extends GetMyContactsState{}
class GetMyContactsLoadingState extends GetMyContactsState{}
class GetMyContactsSuccessState extends GetMyContactsState{
  final List<Contact> myContacts;

 const GetMyContactsSuccessState({required this.myContacts});
}

class GetMyContactsFailureState extends GetMyContactsState{
    final String message;

 const GetMyContactsFailureState({required this.message});
}
