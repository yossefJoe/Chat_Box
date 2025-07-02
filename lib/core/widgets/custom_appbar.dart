import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool centerTitle;
  final Color? backgroundColor;
  final double elevation;
  final List<Widget>? actions;
  final Color? titleColor;
  final bool automaticallyImplyLeading;

  const CustomAppBar({
    Key? key,
    this.title,
    this.centerTitle = true,
    this.backgroundColor,
    this.elevation = 0.0,
    this.actions,
    this.titleColor,
    this.automaticallyImplyLeading = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: automaticallyImplyLeading
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      title: title != null
          ? Text(
              title!,
              style: TextStyle(color: titleColor ?? Colors.black),
            )
          : null,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: elevation,
      actions: actions,
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
