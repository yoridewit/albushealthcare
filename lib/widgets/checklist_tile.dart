import 'package:albus/constants/style.dart';
import '../models/checklists.dart';
import 'package:flutter/material.dart';
import '../screens/chapter_index.dart';

class ChecklistTile extends StatelessWidget {
  final Checklist checklist;
  ChecklistTile({this.checklist});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, ChapterIndex.id, arguments: checklist);
      },
      title: Text(
        checklist.title,
        style: Body1TextStyle.copyWith(color: Colors.grey[800]),
      ),
    );
  }
}
