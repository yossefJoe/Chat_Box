import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';
import 'package:zoom_clone/core/resources/firebase_methods.dart';
import 'package:zoom_clone/core/widgets/custom_appbar.dart';
import 'package:zoom_clone/core/widgets/primary_button.dart';
import 'package:zoom_clone/features/settings/settings_body.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.blackColor,
      appBar: const CustomAppBar(
        titleColor: Colors.white,
        title: "Settings",
      ),
      body: Column(
        children: [
          Padding(
              padding:const EdgeInsets.only(top: 20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.w),
                  topRight: Radius.circular(20.w),
                ),
                child: Container(
                  color: ColorManager.whiteColor,
                  child:const Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SettingsBody()),
                ),
              )),
        ],
      ),
    );
  }
}
