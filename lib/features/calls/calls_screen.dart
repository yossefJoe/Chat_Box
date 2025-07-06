import 'package:flutter/material.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';
import 'package:zoom_clone/core/widgets/custom_body.dart';
import 'package:zoom_clone/core/widgets/screen_upper_part.dart';
import 'package:zoom_clone/features/calls/recent_calls_widget.dart';

class CallsScreen extends StatelessWidget {
  const CallsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.blackColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ScreenUpperPart(
                title: "Calls",
                isHome: false,
                icon: Icons.add_call,
                onPressed: () {},
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: CustomBody(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return RecentCallsWidget(
                        name: "Alex Linderson",
                        index: index,
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
