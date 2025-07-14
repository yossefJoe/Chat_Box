import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:zoom_clone/features/Auth/presentation/views/pages/login_screen.dart';
import 'package:zoom_clone/features/Auth/presentation/views/pages/signup_screen.dart';
import 'package:zoom_clone/features/Chat/presentation/views/pages/chat_room_screen.dart';
import 'package:zoom_clone/features/Contacts/data/models/user_data_model.dart';
import 'package:zoom_clone/features/Contacts/presentation/views/pages/contact_info_screen.dart';
import 'package:zoom_clone/welcome_screen.dart';
import 'package:zoom_clone/nav_bar_view.dart';

class AppRoutes {
  static const String inital = '/';
  static const String navBarView = '/nav_bar_view';
  static const String login = '/login';
  static const String register = '/register';
  static const String welcomeScreen = '/welcome_screen';
  static const String chatRoomScreen = '/chat_room_screen';
  static const String contactInfoScreen = '/contact_info_screen';

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.inital,
    routes: [
      GoRoute(
        path: AppRoutes.inital,
        builder: (context, state) => FirebaseAuth.instance.currentUser != null
            ? const NavBarView()
            : const WelcomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: AppRoutes.navBarView,
        builder: (context, state) => const NavBarView(),
      ),
      GoRoute(
        path: AppRoutes.welcomeScreen,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.chatRoomScreen,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          final userData = data["userData"] as UserDataModel;
          return ChatRoomScreen(userData: userData);
        },
      ),
      GoRoute(
        path: AppRoutes.contactInfoScreen,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          final userData = data["userData"] as UserDataModel;
          return ContactInfoScreen(userData: userData);
        },
      ),
    ],
  );
}
