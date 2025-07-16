import 'package:flutter/material.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';
import 'package:zoom_clone/core/resources/styles_manager.dart';
import 'package:zoom_clone/features/Chat/data/models/chat_message_model.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({super.key, required this.message});
  final ChatMessage message;
  @override
  Widget build(BuildContext context) {
    return Text(
      message.message??"",
      style: AppStyles.s14Regular.copyWith(color: ColorManager.whiteColor),
    );
  }
}
