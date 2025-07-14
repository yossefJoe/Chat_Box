import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_clone/core/resources/assets_manager.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';
import 'package:zoom_clone/core/resources/styles_manager.dart';

class EmptyPicWidget extends StatelessWidget {
  const EmptyPicWidget({super.key, required this.userFirstLetter});
  final String userFirstLetter;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: ColorManager.greyColor.withOpacity(0.7),
        shape: BoxShape.circle,
      ),
      child: Center(
          child: Text(userFirstLetter,
              style: AppStyles.s20Regular
                  .copyWith(color: ColorManager.whiteColor))),
    );
  }
}
