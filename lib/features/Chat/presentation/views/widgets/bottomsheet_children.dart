import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:zoom_clone/core/resources/firebase_methods.dart';
import 'package:zoom_clone/core/resources/methods.dart';
import 'package:zoom_clone/core/resources/styles_manager.dart';
import 'package:zoom_clone/features/Chat/data/models/chat_message_model.dart';
import 'package:zoom_clone/features/Chat/presentation/views/widgets/device_contacts/user_device_contacts.dart';
import 'package:zoom_clone/features/Contacts/data/models/user_data_model.dart';

class BottomsheetChildren extends StatefulWidget {
  const BottomsheetChildren({super.key, required this.userData});
  final UserDataModel userData;

  @override
  State<BottomsheetChildren> createState() => _BottomsheetChildrenState();
}

class _BottomsheetChildrenState extends State<BottomsheetChildren> {
  final currentUser = FirebaseHelper.currentUser;

  void sendPhotoMessage() async {
    final otherUid = widget.userData.uid ?? "";
    final imageFile = await Methods.pickImageFromGallery();
    if (imageFile != null) {
      final imageUrl = await Methods.uploadImageToCloudinary(imageFile);
      if (imageUrl != null) {
        ChatMessage message = ChatMessage(
          imageUrl: imageUrl,
          isFromMe: true,
          time: DateTime.now(),
        );
        Methods.basicSendMessage(context, otherUid, message, widget.userData,
            FirebaseHelper.currentUser);
        context.pop();
        FocusScope.of(context).unfocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        featureListtile("Camera", Icons.camera_alt_outlined, "", () {}),
        featureListtile(
            "Documents", FontAwesomeIcons.fileAlt, "Upload your files", () {}),
        featureListtile("Create a poll", FontAwesomeIcons.poll,
            "Create a poll for any query", () {}),
        featureListtile(
            "Media", Icons.perm_media, "Share your photos and videos",
            () async {
          sendPhotoMessage();
        }),
        featureListtile(
            "Contact", Icons.contacts_outlined, "Share your contacts",
            () async {
          context.pop();

          showContactsDialog(context, widget.userData);
        }),
        featureListtile("Location", Icons.location_on_outlined,
            "Share your location", () {}),
      ],
    );
  }

  Widget featureListtile(
      String title, IconData icon, String? subtitle, void Function()? onTap) {
    return ListTile(
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: AppStyles.s14Light,
            )
          : null,
      title: Text(
        title,
        style: AppStyles.s16Medium,
      ),
      leading: Icon(icon),
      onTap: onTap,
    );
  }
}
