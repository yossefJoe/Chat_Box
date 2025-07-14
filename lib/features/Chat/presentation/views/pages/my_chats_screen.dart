
import 'package:flutter/material.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';
import 'package:zoom_clone/core/widgets/custom_body.dart';
import 'package:zoom_clone/core/widgets/screen_upper_part.dart';
import 'package:zoom_clone/features/Chat/presentation/views/widgets/chat_room_widget.dart';
import 'package:zoom_clone/features/Chat/presentation/views/widgets/status_widget.dart';

class MyChatsScreen extends StatelessWidget {
  const MyChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ColorManager.blackColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
         const     ScreenUpperPart(
                title: "Home",
                isHome: true,
              ),
            const   Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.0),
                child: StatusWidget(),
              ),
               Padding(
                padding:  EdgeInsets.only(top: 20.0),
                child:  CustomBody(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const ChatRoomWidget();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
