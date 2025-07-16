import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserImage extends StatelessWidget {
  const UserImage(
      {super.key, required this.imageUrl, this.size, this.wantBorder});
  final String imageUrl;
  final double? size;
  final bool? wantBorder;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? 50.w,
      height: size ?? 50.h,
      decoration: BoxDecoration(
        border: wantBorder == true ? Border.all(color: Colors.white) : null,
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
