import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zoom_clone/core/resources/assets_manager.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';
import 'package:zoom_clone/core/resources/styles_manager.dart';
import 'package:zoom_clone/features/Chat/presentation/views/widgets/user_image.dart';

class ScreenUpperPart extends StatefulWidget {
  const ScreenUpperPart(
      {super.key,
      required this.title,
      required this.isHome,
      this.onPressed,
      this.icon});
  final String title;
  final bool isHome;
  final void Function()? onPressed;
  final IconData? icon;
  @override
  State<ScreenUpperPart> createState() => _ScreenUpperPartState();
}

class _ScreenUpperPartState extends State<ScreenUpperPart> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                FontAwesomeIcons.search,
                color: ColorManager.whiteColor,
              )),
          Text(
            widget.title,
            style: AppStyles.s18Medium.copyWith(color: ColorManager.whiteColor),
          ),
          widget.isHome
              ? const UserImage(
                  imageUrl: AssetsManager.homepic,
                )
              : IconButton(
                  onPressed: widget.onPressed,
                  icon: Icon(
                    widget.icon,
                    size: 30,
                    color: ColorManager.whiteColor,
                  ),
                ),
        ],
      ),
    );
  }
}
