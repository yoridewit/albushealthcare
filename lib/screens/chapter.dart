import 'package:albus/constants/style.dart';
import 'package:albus/models/chapters.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import './chapter_tabs.dart';

class Chapter extends StatelessWidget {
  static const String id = 'chapter_screen';

  //Get checklistname + chaptername from Chapter_tabs.dart
  final String checkListName;
  final String chapterName;
  Chapter({this.checkListName, this.chapterName});

  @override
  Widget build(BuildContext context) {
    //provide an string that represents the current checklist the user is in to pass to the Chapter_index link in _buildList widget
    //We only need the checkListName, the chapterName will be provided by the user in FireBase
    String currentChecklist = checkListName;

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: Container(
        child: StreamBuilder(
          stream: Firestore.instance
              .collection('userbase')
              .document(checkListName)
              .collection('chapter_index')
              .document(chapterName)
              .collection('actions')
              .orderBy('order', descending: false)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            {
              if (!snapshot.hasData) {
                return SpinKitRing(
                  color: Theme.of(context).accentColor,
                );
              }
              if (snapshot.hasError) {
                return Text('error');
              }
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return _buildList(context, snapshot.data.documents[index],
                        currentChecklist);
                  });
            }
          },
        ),
      ),
    );
  }
}

Widget _buildList(
    BuildContext context, DocumentSnapshot document, String currentChecklist) {
  return Card(
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
      child: ListTile(
        title: Text(
          document['text'],
          style: Body1TextStyle,
        ),
        subtitle: Text(
          document['subtitle'],
          style: Body2TextStyle,
        ),
        trailing: document['url'] == null
            ? null
            : Icon(
                Icons.arrow_forward,
                color: Colors.blueAccent,
              ),
        onTap: () {
          Navigator.pushNamed(
            context,
            ChapterTabs.id,
            arguments: Chapters(
                checkListName: currentChecklist, chapterName: document['url']),
          );
        },
      ),
    ),
  );
}
