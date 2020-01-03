import 'package:albus/constants/style.dart';
import 'package:flutter/material.dart';

class InfoListTile extends StatelessWidget {
  final String leadingNumber;
  final String leadingText;
  final String subText;
  final String url;

  InfoListTile({this.leadingNumber, this.leadingText, this.subText, this.url});

  @override
  Widget build(BuildContext context) {
    //if no url is given return a non-clickable ListTile without trailing
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: ListTile(
          title: Text(
            leadingText,
            style: Body1TextStyle,
          ),
          subtitle: Text(
            subText,
            style: Body2TextStyle,
          ),
          trailing: url.isEmpty
              ? null
              : Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.yellow,
                ),
          onTap: url.isEmpty ? null : () {},
        ),
      ),
    );
  }
}
