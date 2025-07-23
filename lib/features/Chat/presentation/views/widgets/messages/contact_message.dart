import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';
import 'package:zoom_clone/core/resources/styles_manager.dart';
import 'package:zoom_clone/core/widgets/text_button.dart';
import 'package:zoom_clone/features/Chat/data/models/chat_message_model.dart';
import 'package:zoom_clone/features/Chat/presentation/views/widgets/messages/time_widget.dart';

class ContactMessage extends StatelessWidget {
  const ContactMessage({super.key, required this.message});
  final ChatMessage message;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.w,
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: message.isFromMe
            ? ColorManager.chatMeColor.withOpacity(0.7)
            : ColorManager.greyColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: message.isFromMe
                    ? ColorManager.whiteColor
                    : ColorManager.primaryColor,
                radius: 25.r,
                child: Text(
                  message.contact?['displayName']
                          ?.substring(0, 1)
                          .toUpperCase() ??
                      '',
                  style: AppStyles.s16Bold,
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.contact?['displayName'] ?? '',
                    style: AppStyles.s16Bold,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    message.contact?['phones'] ?? '',
                    style: AppStyles.s14Regular,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 5),
          Align(
              alignment: message.isFromMe
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: TimeWidget(message: message)),
          const SizedBox(height: 10),
          Divider(
            color: message.isFromMe
                ? ColorManager.blackColor
                : ColorManager.whiteColor,
            height: 1.h,
          ),
          CustomTextButton(
            text: "Call",
            color: ColorManager.primaryColor,
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
