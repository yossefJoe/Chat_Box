import 'package:flutter/material.dart';
import 'package:zoom_clone/core/resources/assets_manager.dart';
import 'package:zoom_clone/core/resources/navigation.dart';
import 'package:zoom_clone/core/resources/routes_manager.dart';
import 'package:zoom_clone/core/resources/styles_manager.dart';
import 'package:zoom_clone/features/Chat/presentation/views/widgets/user_image.dart';

class ContactDetailsWidget extends StatelessWidget {
  final String name;
  final int index;
  final bool showHeader;

  const ContactDetailsWidget({
    super.key,
    required this.name,
    required this.index,
    this.showHeader = false, // default is false
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigationHelper.push(context, AppRoutes.contactInfoScreen);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showHeader)
            Text(
              name.substring(0, 1).toUpperCase(),
              style: AppStyles.s18Bold,
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const UserImage(imageUrl: AssetsManager.chat1),
              const SizedBox(width: 20),
              titleAndLastMessage(),
            ],
          ),
        ],
      ),
    );
  }

  Widget titleAndLastMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: AppStyles.s16Medium),
        const Text(
          "Life is beautiful",
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
