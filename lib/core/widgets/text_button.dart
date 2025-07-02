import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback? onPressed;

  const CustomTextButton({
    Key? key,
    required this.text,
    required this.color,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: color, // sets text and icon color
      ),
      child: Text(text),
    );
  }
}
