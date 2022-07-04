import 'package:flutter/material.dart';

class TransparentAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TransparentAppBar({Key? key, this.title, this.leading, this.action})
      : super(key: key);

  final Widget? title, leading, action;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: title,
      leading: leading ?? SizedBox(),
      automaticallyImplyLeading: false,
      actions: [
        action ?? SizedBox(),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80);
}
