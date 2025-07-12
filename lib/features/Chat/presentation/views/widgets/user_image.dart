import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zoom_clone/core/resources/assets_manager.dart';

class UserImage extends StatelessWidget {
  const UserImage({super.key, required this.imageUrl, this.size});
  final String imageUrl;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? 50.w,
      height: size ?? 50.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: imageUrl.contains("https")
              ? NetworkImage(imageUrl)
              : AssetImage(imageUrl),
          fit: BoxFit.fill,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}
