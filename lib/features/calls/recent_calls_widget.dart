import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zoom_clone/core/resources/assets_manager.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';
import 'package:zoom_clone/core/resources/navigation.dart';
import 'package:zoom_clone/core/resources/routes_manager.dart';
import 'package:zoom_clone/core/resources/styles_manager.dart';
import 'package:zoom_clone/features/Chat/presentation/views/widgets/user_image.dart';

class RecentCallsWidget extends StatelessWidget {
  const RecentCallsWidget({super.key, required this.name, required this.index});
  final String name;
  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigationHelper.push(context, AppRoutes.chatRoomScreen);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const UserImage(imageUrl: AssetsManager.chat1),
          const SizedBox(width: 20),
          titleAndLastMessage(),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(FontAwesomeIcons.phone, color: ColorManager.greyColor, size: 20),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(FontAwesomeIcons.video, color: ColorManager.greyColor, size: 20),
          ),
        ],
      ),
    );
  }

  Widget chooseCallType() {
    return Icon(
      Icons.phone_callback,
      color: index % 2 == 0 ? Colors.red : Colors.green,
      size: 20,
    );
  }

  Widget titleAndLastMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: AppStyles.s18Bold),
        Row(
          children: [
            chooseCallType(),
            const SizedBox(width: 5),
            const Text(
              "Today at 10:00 AM",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }
}
