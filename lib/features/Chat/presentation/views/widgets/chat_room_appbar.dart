import 'package:flutter/material.dart';

class ChatRoomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleChild;
  final bool centerTitle;
  final Color? backgroundColor;
  final double elevation;
  final List<Widget>? actions;
  final Color? titleColor;
  final bool automaticallyImplyLeading;

  const ChatRoomAppbar({
    Key? key,
    this.title,
    this.titleChild,
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
      leading: automaticallyImplyLeading == true
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 20,
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      title: titleChild ??
          (title != null
              ? Text(
                  title!,
                  style: TextStyle(color: titleColor ?? Colors.black),
                )
              : null),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: elevation,
      actions: actions,
      iconTheme: IconThemeData(color: titleColor ?? Colors.black),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
