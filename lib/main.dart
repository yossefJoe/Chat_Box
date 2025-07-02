import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // add this import
import 'package:zoom_clone/core/resources/app_themes.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';
import 'package:zoom_clone/core/resources/routes_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        return MaterialApp.router(
          routerConfig: AppRoutes.router,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: AppThemes.lightTheme,
        );
      },
    );
  }
}
