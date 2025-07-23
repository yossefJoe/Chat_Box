import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';
import 'package:zoom_clone/core/resources/date_formatter.dart';
import 'package:zoom_clone/core/resources/styles_manager.dart';
import 'package:zoom_clone/features/Chat/data/models/chat_message_model.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({super.key, required this.message});
  final ChatMessage message;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 6.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: message.isFromMe
            ? ColorManager.chatMeColor.withOpacity(0.7)
              : ColorManager.greyColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: message.isFromMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(
              message.message ?? "",
              style:
                  AppStyles.s14Regular.copyWith(color: ColorManager.whiteColor),
            ),
            const SizedBox(height: 5),
            Text(
              DateFormatter.formatWhatsAppTime(
                  DateTime.parse(message.time.toString())),
              style:
                  AppStyles.s12Regular.copyWith(color: ColorManager.whiteColor),
            ),
          ],
        ));
  }
}
