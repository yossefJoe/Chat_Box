import 'package:bloc/bloc.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:dartz/dartz.dart';
import 'package:zoom_clone/features/Chat/data/repos/chat_repo_impl.dart';
import 'get_my_contacts_state.dart';

class GetMyContactsCubit extends Cubit<GetMyContactsState> {
  final ChatRepoImpl chatRepoImpl;

  GetMyContactsCubit(this.chatRepoImpl) : super(GetMyContactsInitialState());

  List<Contact> myContacts = [];
  List<Contact> filteredContacts = [];
  String searchQuery = '';

  /// Fetch all device contacts once and cache them
  Future<void> getMyContacts() async {
    emit(GetMyContactsLoadingState());

    final result = await chatRepoImpl.getMyContacts();

    result.fold(
      (failure) => emit(GetMyContactsFailureState(message: failure.toString())),
      (success) {
        myContacts = success;
        filteredContacts.clear();
        searchQuery = '';
        emit(GetMyContactsSuccessState(myContacts: myContacts));
      },
    );
  }

  void searchContacts(String query) {
    final seenNames = <String>{};

    final results = myContacts.where((contact) {
      final name = contact.displayName ?? '';
      final matches = name.toLowerCase().contains(query.toLowerCase());
      if (matches && !seenNames.contains(name)) {
        seenNames.add(name);
        return true;
      }
      return false;
    }).toList();

    filteredContacts = results;
    searchQuery = query;

    // Emit a fresh state with same list reference (to force rebuild)
    emit(GetMyContactsSuccessState(myContacts: List.from(myContacts)));
  }
}
