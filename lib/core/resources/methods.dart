import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import 'package:zoom_clone/core/resources/cloudinary_constants.dart';
import 'package:zoom_clone/core/resources/firebase_methods.dart';
import 'package:zoom_clone/core/resources/navigation.dart';
import 'package:zoom_clone/core/resources/snackbar_helper.dart';
import 'package:http/http.dart' as http;
import 'package:zoom_clone/features/Chat/data/models/chat_message_model.dart';
import 'package:zoom_clone/features/Chat/data/models/chat_room_model.dart';
import 'package:zoom_clone/features/Chat/presentation/cubits/get_chat_messages_cubit/get_chat_messages_cubit.dart';
import 'package:zoom_clone/features/Chat/presentation/cubits/send_message_cubit/send_message_cubit.dart';
import 'package:zoom_clone/features/Contacts/data/models/user_data_model.dart';
import 'package:contacts_service/contacts_service.dart';

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
    final uri =
        Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/auto/upload');

    final mimeTypeData = lookupMimeType(voiceFile.path)?.split('/');
    if (mimeTypeData == null) return null;

    final request = http.MultipartRequest('POST', uri)
      ..fields['upload_preset'] = voiceMessagesUploadPreset
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

  static Future<File?> pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  static Future<String?> uploadImageToCloudinary(File imageFile) async {
    final url =
        Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = imageMessagesUploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final jsonData = json.decode(responseData);
      return jsonData['secure_url'];
    } else {
      print('Cloudinary upload failed: ${response.statusCode}');
      return null;
    }
  }

  static Future<void> downloadFileToDevice(
      String fileUrl, String fileName) async {
    // Step 1: Request storage permission
    if (Platform.isAndroid) {
      PermissionStatus status = await Permission.storage.request();
      if (!status.isGranted) {
        print("Storage permission not granted.");
        return;
      }
    }

    try {
      // Step 2: Get downloads directory
      Directory? downloadsDir;
      if (Platform.isAndroid) {
        downloadsDir = Directory('/storage/emulated/0/ChatBox');
      } else if (Platform.isIOS) {
        downloadsDir = await getExternalStorageDirectory();
      }

      if (downloadsDir == null) {
        print("Could not find a downloads directory.");
        return;
      }

      final filePath = path.join(downloadsDir.path, fileName);

      // Step 3: Download the file
      Dio dio = Dio();
      await dio.download(
        fileUrl,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print(
                "Download Progress: ${(received / total * 100).toStringAsFixed(0)}%");
          }
        },
      );

      print("File downloaded to: $filePath");
    } catch (e) {
      print("Download failed: $e");
    }
  }

  static Future<void> basicSendMessage(BuildContext context, String otherUid,
      ChatMessage message, UserDataModel userData, User? currentUser) async {
    context.read<SendMessageCubit>().sendMessage(
          otherUid,
          message,
          ChatRoom(
            imageUrl: userData.photoUrl ?? "",
            userName: userData.name ?? "",
            chatRoomId: otherUid,
            otherUserId: otherUid,
            createdAt: DateTime.now(),
          ),
          ChatRoom(
              chatRoomId: currentUser?.uid ?? "",
              otherUserId: currentUser?.uid ?? "",
              createdAt: DateTime.now(),
              userName: currentUser?.displayName ?? "none",
              imageUrl: currentUser?.photoURL ?? ""),
        );
    context.read<GetChatMessagesCubit>().addMessage(message);
  }

  static Future<bool> requestContactsPermission() async {
    var status = await Permission.contacts.request();
    return status.isGranted;
  }

  static Future<List<Contact>> getContacts() async {
    bool permissionGranted = await requestContactsPermission();
    if (!permissionGranted) return [];
    final contacts = await ContactsService.getContacts();
    return contacts.toList()
      ..sort((a, b) => (a.displayName ?? '').compareTo(b.displayName ?? ''));
  }
}
