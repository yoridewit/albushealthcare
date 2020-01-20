import 'package:albus/constants/style.dart';
import '../models/checklists.dart';
import 'package:flutter/material.dart';
import '../screens/chapter_index.dart';

class ChecklistTileHome extends StatelessWidget {
  final Checklist checklist;
  ChecklistTileHome({this.checklist});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, ChapterIndex.id, arguments: checklist);
      },
      title: Text(
        checklist.checkListTitle,
        style: Body1TextStyle.copyWith(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
