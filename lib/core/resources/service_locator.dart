import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zoom_clone/features/Auth/data/repos/auth_repo.dart';
import 'package:zoom_clone/features/Auth/data/repos/auth_repo_impl.dart';
import 'package:zoom_clone/features/Auth/presentation/controller/login_cubit/login_cubit.dart';
import 'package:zoom_clone/features/settings/data/repos/settings_repo.dart';
import 'package:zoom_clone/features/settings/data/repos/settings_repo_impl.dart';
import 'package:zoom_clone/features/settings/presentation/cubit/sign_out_cubit/sign_out_cubit.dart';
import 'package:zoom_clone/features/settings/presentation/cubit/user_data_cubit/user_data_cubit.dart';


final getIt = GetIt.instance;

Future<void> initServiceLocator() async {
  // Firebase instances
  // sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // Repositories

  //Auth
  getIt.registerLazySingleton<AuthRepoImpl>(() => AuthRepoImpl());
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl());

  //Settings
  getIt.registerLazySingleton<SettingsRepoImpl>(() => SettingsRepoImpl());
  getIt.registerLazySingleton<SettingsRepo>(() => SettingsRepoImpl());

//Cubits

//Auth
        getIt.registerSingleton(LoginCubit(getIt.get<AuthRepoImpl>()));

        //Settings
        getIt.registerSingleton(UserDataCubit(getIt.get<SettingsRepoImpl>()));
        getIt.registerSingleton(SignOutCubit(getIt.get<SettingsRepoImpl>()));

}
