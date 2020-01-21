import 'package:albus/constants/style.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconButton icon;

  CustomAppBar({this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      title: Text(title),
      actions: <Widget>[icon != null ? icon : Text('')],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(50.0);
}
