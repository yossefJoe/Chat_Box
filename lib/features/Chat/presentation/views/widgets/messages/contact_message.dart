import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';
import 'package:zoom_clone/features/Chat/data/models/chat_message_model.dart';

class ContactMessage extends StatelessWidget {
  const ContactMessage({super.key, required this.message});
  final ChatMessage message;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: ColorManager.primaryColor.withOpacity(0.3),
        radius: 25.r,
        child: Text(
            message.contact?['displayName']?.substring(0, 1).toUpperCase() ??
                ''),
      ),
      title: Text(message.contact?['displayName'] ?? ''),
      subtitle: Text(message.contact?['phones'] ?? ''),
      onTap: () {
        Navigator.pop(context, message.contact);
      },
    );
  }
}
