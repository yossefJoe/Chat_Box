
import 'package:flutter/material.dart';
import 'package:zoom_clone/core/resources/assets_manager.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';
import 'package:zoom_clone/core/resources/methods.dart';
import 'package:zoom_clone/core/resources/navigation.dart';
import 'package:zoom_clone/core/resources/routes_manager.dart';
import 'package:zoom_clone/core/resources/styles_manager.dart';
import 'package:zoom_clone/core/widgets/primary_button.dart';
import 'package:zoom_clone/features/Auth/presentation/views/widgets/another_authentication_button.dart';
import 'package:zoom_clone/features/Auth/presentation/views/widgets/google_sign_in_button.dart'; // add this import

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            stops: const [0.1, 0.5],
            colors: const [
              Color(0xFF2B165D), // Dark violet from top
              Color(0xFF0E0B19), // Dark navy/black at bottom
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(AssetsManager.smallLogo),
                  const SizedBox(height: 20),
                  Text(
                    "Connect Friends easily & quickly",
                    style: AppStyles.s32Regular.copyWith(
                        color: Colors.white,
                        fontSize: 68,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      "Our chat app is the best way to connect with friends and family.",
                      style: AppStyles.s16Light.copyWith(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GoogleSignInButton(
                    onTap: () async {
                      Methods.handleGoogleSignIn(context);
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'OR',
                    style: AppStyles.s16Light.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  PrimaryButton(
                    textColor: ColorManager.blackColor,
                    color: ColorManager.whiteColor,
                    text: "Sign Up with an email",
                    onPressed: () {
                      NavigationHelper.push(context, AppRoutes.register);
                    },
                  ),
                  const SizedBox(height: 20),
                  AnotherAuthenticationButton(
                    text: "Sign in",
                    label: "Existing user?",
                    route: AppRoutes.login,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
