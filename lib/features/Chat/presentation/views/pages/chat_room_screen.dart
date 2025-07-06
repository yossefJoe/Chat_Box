import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zoom_clone/core/resources/assets_manager.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';
import 'package:zoom_clone/core/resources/styles_manager.dart';
import 'package:zoom_clone/core/widgets/custom_appbar.dart';
import 'package:zoom_clone/features/Chat/presentation/views/widgets/chat_message_bar.dart';
import 'package:zoom_clone/features/Chat/presentation/views/widgets/chat_room_appbar.dart';
import 'package:zoom_clone/features/Chat/presentation/views/widgets/user_image.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<String> _dummyMessages = [
    "Hello!",
    "Hi there! How are you?",
    "I'm good, thanks! What about you?",
    "All good. Working on the Flutter project.",
    "Sounds awesome!",
    "Hello!",
    "Hi there! How are you?",
    "I'm good, thanks! What about you?",
    "All good. Working on the Flutter project.",
    "Sounds awesome!",
    "Hello!",
    "Hi there! How are you?",
    "I'm good, thanks! What about you?",
    "All good. Working on the Flutter project.",
    "Sounds awesome!",
  ];
  @override
  void dispose() {
    _scrollController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatRoomAppbar(
        automaticallyImplyLeading: false,
        titleChild: Row(
          children: [
            const UserImage(imageUrl: AssetsManager.status1),
            SizedBox(width: 10.w),
            nameandActive(),
            const Spacer(),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  FontAwesomeIcons.phone,
                  size: 20,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  FontAwesomeIcons.video,
                  size: 20,
                ))
          ],
        ),
      ),
      body: Column(
        children: [
          // Message list
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
              itemCount: _dummyMessages.length,
              itemBuilder: (context, index) {
                bool isMe = index % 2 == 0;
                return Align(
                  alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 6.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: isMe
                          ? ColorManager.chatMeColor
                          : ColorManager.greyColor,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      _dummyMessages[index],
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    ),
                  ),
                );
              },
            ),
          ),

          // Chat input field
          ChatInputBar(
            controller: _messageController,
            onSend: () {
              if (_messageController.text.trim().isNotEmpty) {
                setState(() {
                  _dummyMessages.add(_messageController.text.trim());
                  _messageController.clear();
                });

                Future.delayed(Duration(milliseconds: 100), () {
                  _scrollController
                      .jumpTo(_scrollController.position.maxScrollExtent);
                });
              }
            },
            onRecord: () {
              // TODO: Trigger voice recording logic
              print("Record pressed");
            },
          ),
        ],
      ),
    );
  }

  Widget nameandActive() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Alex Linderson",
          style: AppStyles.s18Bold,
        ),
        Text(
          "Active Now",
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
