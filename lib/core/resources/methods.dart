import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zoom_clone/core/resources/firebase_methods.dart';
import 'package:zoom_clone/core/resources/navigation.dart';
import 'package:zoom_clone/core/resources/snackbar_helper.dart';

class Methods {
  Methods._();

  static void handleGoogleSignIn(BuildContext context) async {
    try {
      final user = await FirebaseHelper.signInWithGoogle();
      if (user != null) {
        final userDate = user.user;
        final uid = userDate?.uid;

        if (uid == null) {
          ToastHelper.showError('User ID is null. Cannot proceed.');
          return;
        }

        final userDoc = FirebaseFirestore.instance.collection('users').doc(uid);
        final docSnapshot = await userDoc.get();

        if (!docSnapshot.exists) {
          await FirebaseHelper.addDocument(
            collectionPath: 'users',
            data: {
              'name': userDate?.displayName,
              'email': userDate?.email,
              'photoUrl': userDate?.photoURL,
              'uid': uid,
            },
          );
        }
        NavigationHelper.goToHome(context);
        ToastHelper.showSuccess(
            'Google Sign-In successful, user document ready.');
      } else {
        ToastHelper.showError(
            'Google Sign-In failed or was cancelled by user.');
      }
    } catch (e) {
      ToastHelper.showError('Error during Google Sign-In: $e');
    }
  }

  void signOutBasedOnProvider() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    final List<UserInfo> providers = user.providerData;

    final hasGoogle = providers.any((p) => p.providerId == 'google.com');

    try {
      if (hasGoogle) {
        // Google sign out
        await FirebaseHelper.signOutGoogle();
      }

      // Sign out from Firebase regardless of provider
      FirebaseHelper.signOut();
    } catch (e) {
      print("Sign out error: $e");
    }
  }
}
