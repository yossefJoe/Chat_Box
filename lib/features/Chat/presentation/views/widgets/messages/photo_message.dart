import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';
import 'package:zoom_clone/core/widgets/custom_network_image.dart';
import 'package:zoom_clone/features/Chat/data/models/chat_message_model.dart';
import 'package:zoom_clone/features/Chat/presentation/views/widgets/image_viewer.dart';
import 'package:zoom_clone/features/Chat/presentation/views/widgets/messages/time_widget.dart';

class PhotoMessage extends StatelessWidget {
  const PhotoMessage({super.key, required this.message});
  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (message.imageUrl != null && message.imageUrl!.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  FullScreenImageViewer(imageUrl: message.imageUrl!),
            ),
          );
        }
      },
      child: Container(
        width: 220.w, // smaller width
        height: 220.h,
        padding: EdgeInsets.all(4.w),
        margin: EdgeInsets.symmetric(vertical: 6.h),
        decoration: BoxDecoration(
          color: message.isFromMe
              ? ColorManager.chatMeColor.withOpacity(0.7)
              : ColorManager.greyColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: CustomNetworkImage(
                imageUrl: message.imageUrl ?? "",
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Positioned(
              bottom: 6.h,
              right: 8.w,
              child: TimeWidget(message: message),
            ),
          ],
        ),
      ),
    );
  }
}
