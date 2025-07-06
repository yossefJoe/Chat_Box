import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zoom_clone/core/resources/styles_manager.dart';

class BottomsheetChildren extends StatelessWidget {
  const BottomsheetChildren({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max, // Important for expanding to fit children

      children: [
        featureListtile("Camera", Icons.camera_alt_outlined, "", () {}),
        featureListtile(
            "Documents", FontAwesomeIcons.fileAlt, "Upload your files", () {}),
        featureListtile("Create a poll", FontAwesomeIcons.poll,
            "Create a poll for any query", () {}),
        featureListtile(
            "Media", Icons.perm_media, "Share your photos and videos", () {}),
        featureListtile(
            "Contact", Icons.contacts_outlined, "Share your contacts", () {}),
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
