import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';
import 'package:zoom_clone/core/resources/firebase_methods.dart';
import 'package:zoom_clone/core/resources/methods.dart';
import 'package:zoom_clone/core/resources/navigation.dart';
import 'package:zoom_clone/core/resources/snackbar_helper.dart';
import 'package:zoom_clone/core/resources/styles_manager.dart';
import 'package:zoom_clone/core/widgets/custom_appbar.dart';
import 'package:zoom_clone/core/widgets/primary_button.dart';
import 'package:zoom_clone/core/widgets/text_field.dart';
import 'package:zoom_clone/features/Auth/presentation/views/widgets/google_sign_in_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn() async {
    setState(() {
      isLoading = true;
    });

    try {
      final user = await FirebaseHelper.signInWithEmail(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (user != null) {
        NavigationHelper.goToHome(context);
      }
    } on FirebaseAuthException catch (e) {
      String message = '';
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found for that email.';
          break;
        case 'wrong-password':
          message = 'Incorrect password provided.';
          break;
        case 'invalid-email':
          message = 'The email address is badly formatted.';
          break;
        case 'user-disabled':
          message = 'This user account has been disabled.';
          break;
        default:
          message = 'Authentication error: ${e.message}';
      }
      ToastHelper.showError(message);
    } catch (e) {
      ToastHelper.showError('Unexpected error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text("Login to Chatbox", style: AppStyles.s24Bold),
              const SizedBox(height: 10),
              const Text(
                  "Weclome back! Signin using your social account or email to continue",
                  style: AppStyles.s16Light,
                  textAlign: TextAlign.center),
              const SizedBox(height: 20),
              GoogleSignInButton(
                borderColor: ColorManager.blackColor,
                onTap: () async {
                  Methods.handleGoogleSignIn(context);
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'OR',
                style: AppStyles.s16Light,
              ),
              const SizedBox(height: 20),
              Form(
                  onChanged: () {
                    setState(() {});
                  },
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Your email",
                          style: AppStyles.s16Medium
                              .copyWith(color: ColorManager.primaryColor)),
                      CustomTextField(
                        controller: emailController,
                        hintText: 'Enter your email',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Text("Your password",
                          style: AppStyles.s16Medium
                              .copyWith(color: ColorManager.primaryColor)),
                      CustomTextField(
                        isPassword: true,
                        controller: passwordController,
                        hintText: 'Enter your password',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'password is required';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 170.h,
                      ),
                      PrimaryButton(
                        isLoading: isLoading,
                        enabled: formKey.currentState?.validate() ?? false,
                        color: ColorManager.primaryColor,
                        text: "Login",
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            _handleSignIn();
                          } else {
                            ToastHelper.showError('Please fill all fields');
                          }
                        },
                      ),
                    ],
                  ))
            ],
          ),
        ),
      )),
    );
  }
}
