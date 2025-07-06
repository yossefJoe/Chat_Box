import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';

class CustomBody extends StatelessWidget {
  const CustomBody({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.w),
        topRight: Radius.circular(20.w),
      ),
      child: Container(
        color: ColorManager.whiteColor,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: itemCount,
            separatorBuilder: (context, index) =>
                const Padding(padding: EdgeInsets.all(15)),
            itemBuilder: itemBuilder,
          ),
        ),
      ),
    );
  }
}
