import 'package:bloc/bloc.dart';
import 'package:zoom_clone/features/Contacts/data/repos/contacts_repo_impl.dart';
import 'package:zoom_clone/features/Contacts/presentation/cubits/get_contacts_cubit/get_contacts_state.dart';

class UserContactsCubit extends Cubit<UserContactsState> {
  final ContactsRepoImpl contactsRepoImpl;

  UserContactsCubit(this.contactsRepoImpl) : super(UserContactsInitialState());

  Future<void> getUserContacts() async {
    emit(UserContactsLoadingState());

    final result = await contactsRepoImpl.getContacts(
      "users",
    );

    result.fold(
      (failure) => emit(UserContactsFailureState(message: failure.message)),
      (success) => emit(UserContactsSuccessState(
        userContacts: success,
      )),
    );
  }
}
