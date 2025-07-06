import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_clone/core/resources/assets_manager.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';
import 'package:zoom_clone/core/resources/styles_manager.dart';

class StatusImageWidget extends StatelessWidget {
  const StatusImageWidget({super.key, required this.cureentIndex});
  final int cureentIndex;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        cureentIndex != 0
            ? getStatusImage()
            : Stack(
                children: [
                  getStatusImage(),
                  Positioned(
                      right: 2,
                      bottom: 2,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            color: ColorManager.whiteColor,
                            shape: BoxShape.circle,
                          ),
                          height: 20.h,
                          child: const Icon(
                            Icons.add,
                            size: 10,
                          ),
                        ),
                      ))
                ],
              ),
        Text(
          "User1",
          style: AppStyles.s16Medium.copyWith(color: ColorManager.whiteColor),
        ),
      ],
    );
  }

  Widget getStatusImage() {
    return CircleAvatar(
      radius: 30.w,
      backgroundColor: ColorManager.greyColor,
      child: Image.asset(
        height: 62.h,
        AssetsManager.status1,
        fit: BoxFit.fill,
      ),
    );
  }
}
