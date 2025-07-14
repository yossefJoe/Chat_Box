import 'package:flutter/material.dart';
import 'package:zoom_clone/core/resources/assets_manager.dart';
import 'package:zoom_clone/core/resources/navigation.dart';
import 'package:zoom_clone/core/resources/routes_manager.dart';
import 'package:zoom_clone/core/resources/styles_manager.dart';
import 'package:zoom_clone/core/widgets/empty_pic_widget.dart';
import 'package:zoom_clone/features/Chat/presentation/views/widgets/user_image.dart';
import 'package:zoom_clone/features/Contacts/data/models/user_data_model.dart';

class ContactDetailsWidget extends StatelessWidget {
  final UserDataModel userData;
  final int index;
  final bool showHeader;

  const ContactDetailsWidget({
    super.key,
    required this.userData,
    required this.index,
    this.showHeader = false, // default is false
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigationHelper.pushToPageWithParams(
            context, AppRoutes.contactInfoScreen, {"userData": userData});
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showHeader)
            Text(
              userData.name?.substring(0, 1).toUpperCase() ?? "",
              style: AppStyles.s18Bold,
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              userData.photoUrl == "none"
                  ? EmptyPicWidget(
                      userFirstLetter:
                          userData.name?.substring(0, 1).toUpperCase() ?? "")
                  : UserImage(imageUrl: userData.photoUrl ?? ""),
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
        Text(userData.name ?? "", style: AppStyles.s16Medium),
        const Text(
          "Life is beautiful",
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
