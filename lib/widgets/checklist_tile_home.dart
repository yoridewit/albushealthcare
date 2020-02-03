import 'package:albus/constants/style.dart';
import '../models/checklists.dart';
import 'package:flutter/material.dart';
import '../screens/chapter_index.dart';

class ChecklistTileHome extends StatelessWidget {
  final Checklist checklist;
  ChecklistTileHome({this.checklist});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ChapterIndex.id, arguments: checklist);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF3F5F7),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Text(
            checklist.checkListTitle,
            style: Body1TextStyle.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
