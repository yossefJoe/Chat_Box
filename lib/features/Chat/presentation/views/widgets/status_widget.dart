import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';
import 'package:zoom_clone/features/Chat/presentation/views/widgets/status_image_widget.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      child: ListView.separated(
          separatorBuilder: (context, index) =>
              Padding(padding: EdgeInsets.all(10.w)),
          scrollDirection: Axis.horizontal,
          itemCount: 8,
          itemBuilder: (context, index) {
            return StatusImageWidget(
              cureentIndex: index,
            );
          }),
    );
  }
}
