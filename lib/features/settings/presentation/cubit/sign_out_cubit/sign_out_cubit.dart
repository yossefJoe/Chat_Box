import 'package:bloc/bloc.dart';
import 'package:zoom_clone/features/Auth/data/models/signup_params_model.dart';
import 'package:zoom_clone/features/Auth/data/repos/auth_repo_impl.dart';
import 'package:zoom_clone/features/settings/data/repos/settings_repo_impl.dart';
import 'package:zoom_clone/features/settings/presentation/cubit/sign_out_cubit/sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  final SettingsRepoImpl settingsRepoImpl;

  SignOutCubit(this.settingsRepoImpl) : super(SignOutInitialState());

  Future<void> signOut() async {
    emit(SignOutLoadingState());

    final result = await settingsRepoImpl.signOut(
    );

    result.fold(
      (failure) => emit(SignOutFailureState(message: failure.message)),
      (_) => emit(SignOutSuccessState()),
    );
  }
}
