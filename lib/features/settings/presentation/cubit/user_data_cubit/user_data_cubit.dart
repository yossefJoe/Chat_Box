import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zoom_clone/features/Auth/data/models/signup_params_model.dart';
import 'package:zoom_clone/features/Auth/data/repos/auth_repo_impl.dart';
import 'package:zoom_clone/features/settings/data/repos/settings_repo_impl.dart';
import 'package:zoom_clone/features/settings/presentation/cubit/user_data_cubit/user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  final SettingsRepoImpl settingsRepoImpl;

  UserDataCubit(this.settingsRepoImpl) : super(UserDataInitialState());

  Future<void> getUserData() async {
    emit(UserDataLoadingState());

    final result = await settingsRepoImpl.getUserData(
      "users",
    );

    result.fold(
      (failure) => emit(UserDataFailureState(message: failure.message)),
      (success) => emit(UserDataSuccessState(
        userData: success,
      )),
    );
  }
}
