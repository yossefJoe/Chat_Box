import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';
import 'package:zoom_clone/core/resources/date_formatter.dart';
import 'package:zoom_clone/core/resources/styles_manager.dart';
import 'package:zoom_clone/features/Chat/data/models/chat_message_model.dart';
import 'package:zoom_clone/features/Chat/presentation/views/widgets/messages/contact_message.dart';
import 'package:zoom_clone/features/Chat/presentation/views/widgets/messages/photo_message.dart';
import 'package:zoom_clone/features/Chat/presentation/views/widgets/messages/text_message.dart';
import 'package:zoom_clone/features/Chat/presentation/views/widgets/messages/voice_message.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({super.key, required this.message});
  final ChatMessage message;
  Widget chooseMessageWidget(ChatMessage message) {
    if (message.imageUrl != null) {
      return PhotoMessage(message: message);
    } else if (message.isLocation??false) {
      return TextMessage(message: message);
    } else if (message.voiceUrl != null) {
      return VoiceMessage(audioUrl: message.voiceUrl!);
    } else if (message.isVideoCall??false) {
      return TextMessage(message: message);
    } else if (message.isVoiceCall??false) {
      return TextMessage(message: message);
    } else if (message.contact != null) {
      return ContactMessage(message: message);
    }
    
     else {
      return TextMessage(message: message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          message.isFromMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 6.h),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: message.isFromMe
                ? ColorManager.chatMeColor
                : ColorManager.greyColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: message.isFromMe
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              chooseMessageWidget(message),
              const SizedBox(height: 5),
              Text(
                DateFormatter.formatWhatsAppTime(
                    DateTime.parse(message.time.toString())),
                style: AppStyles.s12Regular
                    .copyWith(color: ColorManager.whiteColor),
              ),
            ],
          )),
    );
  }
}
