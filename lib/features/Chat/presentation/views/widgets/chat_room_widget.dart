import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_clone/core/resources/assets_manager.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';
import 'package:zoom_clone/core/resources/date_formatter.dart';
import 'package:zoom_clone/core/resources/navigation.dart';
import 'package:zoom_clone/core/resources/routes_manager.dart';
import 'package:zoom_clone/core/resources/styles_manager.dart';
import 'package:zoom_clone/core/widgets/empty_pic_widget.dart';
import 'package:zoom_clone/features/Chat/data/models/chat_message_model.dart';
import 'package:zoom_clone/features/Chat/presentation/cubits/get_chat_rooms_cubit/get_chat_rooms_cubit.dart';
import 'package:zoom_clone/features/Chat/presentation/views/widgets/user_image.dart';
import 'package:zoom_clone/features/Contacts/data/models/user_data_model.dart';

class ChatRoomWidget extends StatelessWidget {
  const ChatRoomWidget(
      {super.key, required this.userData, required this.messages});
  final UserDataModel userData;
  final List<ChatMessage> messages;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigationHelper.pushToPageWithParams(
            context, AppRoutes.chatRoomScreen, {"userData": userData});
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          userData.photoUrl == "none"
              ? EmptyPicWidget(
                  userFirstLetter:
                      userData.name?.substring(0, 1).toUpperCase() ?? "")
              : UserImage(imageUrl: userData.photoUrl ?? ""),
          const SizedBox(
            width: 20,
          ),
          titleandLastMessage(),
          const Spacer(),
          timeofLastMessageandnewMessage(),
        ],
      ),
    );
  }

  Widget titleandLastMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          userData.name ?? "",
          style: AppStyles.s18Bold,
        ),
        chooseLastMessageWidget(),
      ],
    );
  }

  Widget timeofLastMessageandnewMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          DateFormatter.formatTimeAgo(messages.last.time),
          style: AppStyles.s12Regular,
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          // padding: const EdgeInsets.all(4.0),
          decoration: const BoxDecoration(
            color: ColorManager.failureColor,
            shape: BoxShape.circle,
          ),
          child: Center(
              child: Text(
            messages
                .where((element) =>
                    element.isRead == false && element.isFromMe == false)
                .length
                .toString(),
            style: AppStyles.s12Medium.copyWith(color: ColorManager.whiteColor),
          )),
          height: 25,
          width: 25,
        )
      ],
    );
  }

  Widget chooseLastMessageWidget() {
    if (messages.last.imageUrl != null) {
      return Text("Media");
    } else if (messages.last.isLocation ?? false) {
      return Text("Location");
    } else if (messages.last.voiceUrl != null) {
      return Row(
        children: [
          _messageIsRead(),
          const SizedBox(width: 10),
          Icon(Icons.mic),
          const SizedBox(width: 10),
          Text("Voice Message"),
        ],
      );
    } else if (messages.last.isVideoCall ?? false) {
      return Text("Video Call");
    } else if (messages.last.isVoiceCall ?? false) {
      return Text("Voice Call");
    } else {
      return Row(
        children: [
          messages.last.isFromMe == true
              ? _messageIsRead()
              : const SizedBox.shrink(),
          const SizedBox(width: 10),
          SizedBox(
            width: 150.w,
            child: Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              messages.last.message ?? "",
              style: AppStyles.s14Regular,
            ),
          ),
        ],
      );
    }
  }

  Widget _messageIsRead() {
    return messages.last.isRead == false
        ? const Icon(Icons.check)
        : const Icon(Icons.check_circle_outline);
  }
}
