import 'package:bloc/bloc.dart';
import 'package:zoom_clone/features/Chat/data/repos/chat_repo_impl.dart';
import 'package:zoom_clone/features/Chat/presentation/cubits/get_my_contacts_cubit/get_my_contacts_state.dart';

class GetMyContactsCubit extends Cubit<GetMyContactsState> {
  final ChatRepoImpl chatRepoImpl;

  GetMyContactsCubit(this.chatRepoImpl) : super(GetMyContactsInitialState());

  Future<void> getMyContacts() async {
    emit(GetMyContactsLoadingState());

    final result = await chatRepoImpl.getMyContacts(
    );

    result.fold(
      (failure) => emit(GetMyContactsFailureState(message: failure.toString())),
      (success) => emit(GetMyContactsSuccessState(
        myContacts: success,
      )),
    );
  }
}
