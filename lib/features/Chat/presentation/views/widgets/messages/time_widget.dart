import 'package:flutter/material.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';
import 'package:zoom_clone/core/resources/date_formatter.dart';
import 'package:zoom_clone/core/resources/styles_manager.dart';
import 'package:zoom_clone/features/Chat/data/models/chat_message_model.dart';

class TimeWidget extends StatelessWidget {
  const TimeWidget({super.key, required this.message});
  final ChatMessage message;
  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormatter.formatWhatsAppTime(DateTime.parse(message.time.toString())),
      style: AppStyles.s12Regular.copyWith(color: ColorManager.whiteColor),
    );
  }
}
