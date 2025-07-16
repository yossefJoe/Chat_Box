import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:zoom_clone/core/resources/firebase_methods.dart';
import 'package:zoom_clone/core/resources/navigation.dart';
import 'package:zoom_clone/core/resources/snackbar_helper.dart';
import 'package:http/http.dart' as http;

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
            docId: uid,
            data: {
              'name': userDate?.displayName,
              'email': userDate?.email,
              'photoUrl': userDate?.photoURL,
              'uid': uid,
              'bio': '',
              'active': true,
              'phoneNumber': '',
              'address': ''
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

  static Future<String?> uploadVoiceToCloudinary(File voiceFile) async {
    final cloudName = 'dnxkdxdvj';
    final uploadPreset = 'Chat_box_voice_messages';

    final uri =
        Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/auto/upload');

    final mimeTypeData = lookupMimeType(voiceFile.path)?.split('/');
    if (mimeTypeData == null) return null;

    final request = http.MultipartRequest('POST', uri)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(
        await http.MultipartFile.fromPath(
          'file',
          voiceFile.path,
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
        ),
      );

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final decodedData = json.decode(responseData);
      return decodedData['secure_url']; // This is the uploaded file's URL
    } else {
      print('Failed to upload to Cloudinary: ${response.statusCode}');
      return null;
    }
  }
}
