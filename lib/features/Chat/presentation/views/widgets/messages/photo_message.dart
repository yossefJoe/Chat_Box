import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_clone/core/widgets/custom_network_image.dart';
import 'package:zoom_clone/features/Chat/data/models/chat_message_model.dart';
import 'package:zoom_clone/features/Chat/presentation/views/widgets/image_viewer.dart';

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
          width: 200.w,
          height: 200.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: CustomNetworkImage(imageUrl: message.imageUrl ?? ""),
        ));
  }
}
