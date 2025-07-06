import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zoom_clone/core/resources/assets_manager.dart';
import 'package:zoom_clone/core/resources/firebase_methods.dart';
import 'package:zoom_clone/core/resources/styles_manager.dart';
import 'package:zoom_clone/core/widgets/primary_button.dart';
import 'package:zoom_clone/features/Chat/presentation/views/widgets/user_image.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            UserImage(
              imageUrl: AssetsManager.homepic,
              size: 60,
            ),
            const SizedBox(width: 20),
            titleandBio(),
          ],
        ),
        SizedBox(height: 10),
        featureListtile(
            "Account", Icons.person, "Manage your account details", () {}),
        featureListtile("Notifications", Icons.notifications,
            "Manage your notifications", () {}),
        featureListtile("Help", Icons.help, "Get help with Zoom", () {}),
        featureListtile("Invite Friends", Icons.share,
            "Invite your friends to Zoom", () {}),
        featureListtile("Logout", Icons.logout, "Quit the app", () {
          FirebaseHelper.signOutGoogle();
        }),
      ],
    );
  }

  Widget featureListtile(
      String title, IconData icon, String subtitle, void Function()? onTap) {
    return ListTile(
      subtitle: Text(
        subtitle,
        style: AppStyles.s14Light,
      ),
      title: Text(
        title,
        style: AppStyles.s16Medium,
      ),
      leading: Icon(icon),
      onTap: onTap,
    );
  }

  Widget titleandBio() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Alex Linderson",
          style: AppStyles.s18Bold,
        ),
        const Text(
          "Never Give Up",
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
