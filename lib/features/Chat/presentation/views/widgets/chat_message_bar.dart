import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';
import 'package:zoom_clone/features/Chat/presentation/views/widgets/attachment_bottomsheet.dart';
import 'package:zoom_clone/features/Contacts/data/models/user_data_model.dart';

class ChatInputBar extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onRecord;
  final UserDataModel userData;

  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onSend,
    required this.onRecord, required this.userData,
  });

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  bool isWriting = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateState);
  }

  void _updateState() {
    final hasText = widget.controller.text.trim().isNotEmpty;
    if (hasText != isWriting) {
      setState(() {
        isWriting = hasText;
      });
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        child: Row(
          children: [
            IconButton(
              onPressed: () async{
            await    showAttachmentBottomSheet(context,widget.userData );
            setState(() {
              
            });
              },
              icon: Transform.rotate(
                angle: 45 * 3.1416 / 180, // convert degrees to radians
                child: const Icon(Icons.attach_file),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                decoration: BoxDecoration(
                  color: const Color(0xffF3F6F6),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          setState(() {});
                        },
                        controller: widget.controller,
                        minLines: 1,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: "Type your message...",
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10.w),
            isWriting
                ? GestureDetector(
                    onTap: widget.onSend,
                    child: CircleAvatar(
                      radius: 20.r,
                      backgroundColor: ColorManager.chatMeColor,
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  )
                : IconButton(
                    onPressed: widget.onRecord,
                    icon: const Icon(FontAwesomeIcons.microphone, size: 20),
                  ),
          ],
        ),
      ),
    );
  }
}
