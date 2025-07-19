import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // add this import
import 'package:zoom_clone/core/resources/app_themes.dart';
import 'package:zoom_clone/core/resources/bloc_observer.dart';
import 'package:zoom_clone/core/resources/routes_manager.dart';
import 'package:zoom_clone/features/Auth/presentation/controller/login_cubit/login_cubit.dart';
import 'package:zoom_clone/core/resources/service_locator.dart' as sl;
import 'package:zoom_clone/features/Chat/presentation/cubits/get_chat_messages_cubit/get_chat_messages_cubit.dart';
import 'package:zoom_clone/features/Chat/presentation/cubits/get_chat_rooms_cubit/get_chat_rooms_cubit.dart';
import 'package:zoom_clone/features/Chat/presentation/cubits/get_my_contacts_cubit/get_my_contacts_cubit.dart';
import 'package:zoom_clone/features/Chat/presentation/cubits/send_message_cubit/send_message_cubit.dart';
import 'package:zoom_clone/features/Contacts/presentation/cubits/get_contacts_cubit/get_contacts_cubit.dart';
import 'package:zoom_clone/features/settings/presentation/cubit/sign_out_cubit/sign_out_cubit.dart';
import 'package:zoom_clone/features/settings/presentation/cubit/user_data_cubit/user_data_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await sl.initServiceLocator();
    Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
          375, 812), // typical iPhone X size, change as per your design
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<LoginCubit>(
              create: (context) => sl.getIt<LoginCubit>(),
            ),
            BlocProvider<UserDataCubit>(
              create: (context) => sl.getIt<UserDataCubit>(),
            ),
            BlocProvider<SignOutCubit>(
              create: (context) => sl.getIt<SignOutCubit>(),
            ),
            BlocProvider<UserContactsCubit>(
              create: (context) => sl.getIt<UserContactsCubit>(),
            ),
            BlocProvider<GetChatRoomsCubit>(
              create: (context) => sl.getIt<GetChatRoomsCubit>(),
            ),
            BlocProvider<GetChatMessagesCubit>(
              create: (context) => sl.getIt<GetChatMessagesCubit>(),
            ),
            BlocProvider<SendMessageCubit>(
              create: (context) => sl.getIt<SendMessageCubit>(),
            ),
            BlocProvider<GetMyContactsCubit>(
              create: (context) => sl.getIt<GetMyContactsCubit>()..getMyContacts(),
            ),
          ],
          child: MaterialApp.router(
            routerConfig: AppRoutes.router,
            debugShowCheckedModeBanner: false,
            title: 'Chat Box',
            theme: AppThemes.lightTheme,
          ),
        );
      },
    );
  }
}
