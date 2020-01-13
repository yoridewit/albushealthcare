import 'package:flutter/material.dart';

class Documents with ChangeNotifier {
  String _checklistName;
  String _chapterName;
  String _chapterSection;

  String get checklistName {
    return _checklistName;
  }

  String get chapterName {
    return _chapterName;
  }

  String get chapterSection {
    return _chapterSection;
  }

  void updateChecklistName(checklistName) {
    _checklistName = checklistName;
    notifyListeners();
  }

  void updateChapterName(chapterName) {
    _chapterName = chapterName;
    notifyListeners();
  }

  void updateChapterSection(chapterSection) {
    _chapterSection = chapterSection;
    notifyListeners();
  }
}
