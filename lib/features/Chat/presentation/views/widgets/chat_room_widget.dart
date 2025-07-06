import 'package:flutter/material.dart';
import 'package:zoom_clone/core/resources/assets_manager.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';
import 'package:zoom_clone/core/resources/navigation.dart';
import 'package:zoom_clone/core/resources/routes_manager.dart';
import 'package:zoom_clone/core/resources/styles_manager.dart';
import 'package:zoom_clone/features/Chat/presentation/views/widgets/user_image.dart';

class ChatRoomWidget extends StatelessWidget {
  const ChatRoomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigationHelper.push(context, AppRoutes.chatRoomScreen);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const UserImage(
            imageUrl: AssetsManager.chat1,
          ),
          const SizedBox(
            width: 20,
          ),
          titleandLastMessage(),
          Spacer(),
          timeofLastMessageandnewMessage(),
        ],
      ),
    );
  }

  Widget titleandLastMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Alex Linderson",
          style: AppStyles.s18Bold,
        ),
        const Text(
          "How are you today?",
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget timeofLastMessageandnewMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          "2 min ago",
          style: TextStyle(fontSize: 12),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          // padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: ColorManager.failureColor,
            shape: BoxShape.circle,
          ),
          child: Center(
              child: Text(
            "3",
            style: AppStyles.s12Medium.copyWith(color: ColorManager.whiteColor),
          )),
          height: 25,
          width: 25,
        )
      ],
    );
  }
}
