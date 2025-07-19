import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zoom_clone/features/Auth/data/repos/auth_repo.dart';
import 'package:zoom_clone/features/Auth/data/repos/auth_repo_impl.dart';
import 'package:zoom_clone/features/Auth/presentation/controller/login_cubit/login_cubit.dart';
import 'package:zoom_clone/features/Chat/data/repos/chat_repo.dart';
import 'package:zoom_clone/features/Chat/data/repos/chat_repo_impl.dart';
import 'package:zoom_clone/features/Chat/presentation/cubits/get_chat_messages_cubit/get_chat_messages_cubit.dart';
import 'package:zoom_clone/features/Chat/presentation/cubits/get_chat_rooms_cubit/get_chat_rooms_cubit.dart';
import 'package:zoom_clone/features/Chat/presentation/cubits/get_my_contacts_cubit/get_my_contacts_cubit.dart';
import 'package:zoom_clone/features/Chat/presentation/cubits/send_message_cubit/send_message_cubit.dart';
import 'package:zoom_clone/features/Contacts/data/repos/contacts_repo.dart';
import 'package:zoom_clone/features/Contacts/data/repos/contacts_repo_impl.dart';
import 'package:zoom_clone/features/Contacts/presentation/cubits/get_contacts_cubit/get_contacts_cubit.dart';
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

  // contacts

  getIt.registerLazySingleton<ContactsRepoImpl>(() => ContactsRepoImpl());
    getIt.registerLazySingleton<ContactsRepo>(() => ContactsRepoImpl());

  // chat 
    getIt.registerLazySingleton<ChatRepoImpl>(() => ChatRepoImpl());
      getIt.registerLazySingleton<ChatRepo>(() => ChatRepoImpl());

//Cubits

//Auth
        getIt.registerSingleton(LoginCubit(getIt.get<AuthRepoImpl>()));

        //Settings
        getIt.registerSingleton(UserDataCubit(getIt.get<SettingsRepoImpl>()));
        getIt.registerSingleton(SignOutCubit(getIt.get<SettingsRepoImpl>()));

        // Contacts
        getIt.registerSingleton(UserContactsCubit(getIt.get<ContactsRepoImpl>()));

        // Chat
        getIt.registerSingleton(GetChatRoomsCubit(getIt.get<ChatRepoImpl>()));
        getIt.registerSingleton(GetChatMessagesCubit(getIt.get<ChatRepoImpl>()));
        getIt.registerSingleton(SendMessageCubit(getIt.get<ChatRepoImpl>()));
        getIt.registerSingleton(GetMyContactsCubit(getIt.get<ChatRepoImpl>()));

}
