import 'package:albus/constants/style.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconButton icon;

  CustomAppBar({this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: new IconThemeData(color: Color(0xFFF3F5F7)),
      elevation: 0.0,
      title: Text(
        title,
        style: Body1TextStyle.copyWith(fontSize: 18),
      ),
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      actions: <Widget>[icon != null ? icon : Text('')],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(50.0);
}
