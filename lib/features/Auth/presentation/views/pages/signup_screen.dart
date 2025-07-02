import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';
import 'package:zoom_clone/core/resources/firebase_methods.dart';
import 'package:zoom_clone/core/resources/navigation.dart';
import 'package:zoom_clone/core/resources/snackbar_helper.dart';
import 'package:zoom_clone/core/resources/styles_manager.dart';
import 'package:zoom_clone/core/widgets/custom_appbar.dart';
import 'package:zoom_clone/core/widgets/primary_button.dart';
import 'package:zoom_clone/core/widgets/text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    try {
      setState(() {
        isLoading = true;
      });

      final userCredential = await FirebaseHelper.registerWithEmail(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (userCredential != null) {
        final user = userCredential.user;
        final uid = user?.uid;

        if (uid != null) {
          final userDoc =
              FirebaseFirestore.instance.collection('users').doc(uid);
          final docSnapshot = await userDoc.get();

          if (!docSnapshot.exists) {
            await FirebaseHelper.addDocument(
              collectionPath: 'users',
              data: {
                'name':
                    nameController.text, // Firebase doesn't set name by default
                'email': emailController.text,
                'photoUrl': "", // optional
                'uid': uid,
              },
            );
          }

          NavigationHelper.goToLogin(context);
        } else {
          ToastHelper.showError("Something went wrong. User ID is missing.");
        }
      }
    } on FirebaseAuthException catch (e) {
      String message = '';
      switch (e.code) {
        case 'email-already-in-use':
          message =
              'This email is already registered. Please login or use another email.';
          break;
        case 'invalid-email':
          message = 'The email address is badly formatted.';
          break;
        case 'operation-not-allowed':
          message = 'Email/password accounts are not enabled.';
          break;
        case 'weak-password':
          message =
              'The password is too weak. Please choose a stronger password.';
          break;
        default:
          message = 'Registration error: ${e.message}';
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
              Text("Login to Chatbox", style: AppStyles.s24Bold),
              const SizedBox(height: 10),
              Text(
                  "Weclome back! Signin using your social account or email to continue",
                  style: AppStyles.s16Light,
                  textAlign: TextAlign.center),
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
                      Text("Your name",
                          style: AppStyles.s16Medium
                              .copyWith(color: ColorManager.primaryColor)),
                      CustomTextField(
                        controller: nameController,
                        hintText: 'Enter your name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name is required';
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
                      const SizedBox(height: 20),
                      Text("Confirm password",
                          style: AppStyles.s16Medium
                              .copyWith(color: ColorManager.primaryColor)),
                      CustomTextField(
                        isPassword: true,
                        controller: confirmPasswordController,
                        hintText: 'Re enter your password',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'password needs to be confirmed';
                          }
                          if (value != passwordController.text) {
                            return 'Passwords do not match';
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
                        text: "Create account",
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            _handleRegister();
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
