import 'package:albus/constants/style.dart';
import '../models/checklists.dart';
import 'package:flutter/material.dart';
import '../screens/chapter_index.dart';

class ChecklistTileDrawer extends StatelessWidget {
  final Checklist checklist;
  ChecklistTileDrawer({this.checklist});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, ChapterIndex.id, arguments: checklist);
      },
      title: Text(
        checklist.checkListTitle,
        style: Body1TextStyle.copyWith(color: Colors.grey[800], fontSize: 15),
      ),
    );
  }
}
