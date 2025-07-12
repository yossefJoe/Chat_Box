import 'package:bloc/bloc.dart';
import 'package:zoom_clone/features/Auth/data/models/signup_params_model.dart';
import 'package:zoom_clone/features/Auth/data/repos/auth_repo_impl.dart';
import 'package:zoom_clone/features/Auth/presentation/controller/login_cubit/login_state.dart';

class LoginCubit extends Cubit<LogInState> {
  final AuthRepoImpl authRepoImpl;

  LoginCubit(this.authRepoImpl) : super(LoginInitialState());

  Future<void> login(SignupParamsModel signupParamsModel) async {
    emit(LoginLoadingState());

    final result = await authRepoImpl.signInWithEmailAndPassword(
      signupParamsModel: signupParamsModel,
    );

    result.fold(
      (failure) => emit(LoginFailureState(message: failure.message)),
      (_) => emit(LoginSuccessState()),
    );
  }
}
