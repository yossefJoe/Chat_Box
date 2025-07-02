import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zoom_clone/core/resources/firebase_methods.dart';
import 'package:zoom_clone/core/widgets/primary_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            PrimaryButton(
                text: "logout",
                onPressed: () {
                  FirebaseHelper.signOutGoogle();
                }),
          ],
        ),
      ),
    );
  }
}
