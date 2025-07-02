import 'package:flutter/material.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';
import 'package:zoom_clone/core/resources/navigation.dart';
import 'package:zoom_clone/core/resources/routes_manager.dart';
import 'package:zoom_clone/core/resources/styles_manager.dart';
import 'package:zoom_clone/core/widgets/text_button.dart';

class AnotherAuthenticationButton extends StatelessWidget {
  const AnotherAuthenticationButton({super.key, required this.text, required this.route, required this.label});
final String text;
final String label;
final String route;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label,
            style: AppStyles.s16Light.copyWith(color: Colors.white)),
        CustomTextButton(
          text: text,
          color: ColorManager.whiteColor,
          onPressed: () {
            NavigationHelper.push(context, route);
          },
        ),
      ],
    );
  }
}
