import 'package:albus/constants/style.dart';
import 'package:albus/models/chapters.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import './chapter_tabs.dart';

class Chapter extends StatefulWidget {
  static const String id = 'chapter_screen';
  final String checkListName;
  final String chapterName;
  Chapter({this.checkListName, this.chapterName});

  @override
  _ChapterState createState() => _ChapterState();
}

class _ChapterState extends State<Chapter> {
  String error = 'Nothing found.';

  @override
  Widget build(BuildContext context) {
    //provide an string that represents the current checklist the user is in to pass to the Chapter_index link in _buildList widget
    //We only need the checkListName, the chapterName will be provided by the user in FireBase
    String currentChecklist = widget.checkListName;

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: Stack(
        children: <Widget>[
          StreamBuilder(
            stream: Firestore.instance
                .collection('userbase')
                .document(widget.checkListName)
                .collection('chapter_index')
                .document(widget.chapterName)
                .collection('actions')
                .orderBy('order', descending: false)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              if (snapshot.data.documents.length < 1) {
                return Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 120),
                      Image.asset(
                        'assets/error.png',
                        width: 175,
                      ),
                      SizedBox(height: 50),
                      Text(
                        'No data found',
                        style: Body1TextStyle.copyWith(
                            color: Colors.white, fontSize: 32),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'No internet connection',
                        style: Body1TextStyle.copyWith(color: Colors.white),
                      ),
                      Text(
                        'or',
                        style: Body2TextStyle.copyWith(color: Colors.white),
                      ),
                      Text(
                        'The current checklist section is empty',
                        style: Body1TextStyle.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                print('connectionstate waiting');
                return SpinKitRing(
                  color: Theme.of(context).accentColor,
                );
              }
              if (snapshot.hasError) {
                print('snapshot error');
                return Text('error');
              }
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                padding: EdgeInsets.only(bottom: 70, top: 10),
                itemBuilder: (context, index) {
                  return _buildList(
                      context,
                      snapshot.data.documents[index],
                      currentChecklist,
                      widget.checkListName,
                      widget.chapterName);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

Widget _buildList(BuildContext context, DocumentSnapshot document,
    String currentChecklist, String checklistName, String chapterName) {
  String docId = document.documentID;
  return Card(
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(horizontal: 5, vertical: 6.0),
    child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF3F5F7),
          borderRadius: BorderRadius.circular(2),
        ),
        child: document['url'] == '' || document['url'] == null
            ? Column(
                children: <Widget>[
                  SizedBox(height: 5),
                  ListTile(
                    title: Text(
                      document['text'],
                      style: Body1TextStyle.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 5),
                        StreamBuilder(
                          stream: Firestore.instance
                              .collection('userbase')
                              .document(checklistName)
                              .collection('chapter_index')
                              .document(chapterName)
                              .collection('actions')
                              .document(docId)
                              .collection('subtext')
                              .orderBy('order', descending: false)
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (context, index) {
                                  return _buildSubTextStrings(
                                      context,
                                      snapshot.data.documents[index],
                                      currentChecklist);
                                },
                              );
                            }
                          },
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                children: <Widget>[
                  ListTile(
                    title: Text(document['text'],
                        style: Body1TextStyle.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w600)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 5),
                        StreamBuilder(
                          stream: Firestore.instance
                              .collection('userbase')
                              .document(checklistName)
                              .collection('chapter_index')
                              .document(chapterName)
                              .collection('actions')
                              .document(docId)
                              .collection('subtext')
                              .orderBy('order', descending: false)
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (context, index) {
                                  return _buildSubTextStrings(
                                      context,
                                      snapshot.data.documents[index],
                                      checklistName);
                                },
                              );
                            }
                          },
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: Theme.of(context).accentColor,
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        ChapterTabs.id,
                        arguments: Chapters(
                            checkListName: currentChecklist,
                            chapterName: document['url']),
                      );
                    },
                  ),
                ],
              )),
  );
}

Widget _buildSubTextStrings(
    BuildContext context, DocumentSnapshot document, String checklistName) {
  return document['bold'] == true
      ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(width: 5),
                Icon(Icons.arrow_right),
                Flexible(
                  child: Container(
                    child: Text('${document['text']}',
                        style: Body1TextStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            color: document['url'] == ''
                                ? Colors.blue
                                : Color.fromRGBO(58, 66, 86, 0.9),
                            fontSize: 15,
                            decoration:
                                document['url'] == null || document['url'] == ''
                                    ? null
                                    : TextDecoration.underline,
                            letterSpacing: 0)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
          ],
        )
      : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(width: 40),
                Icon(Icons.fiber_manual_record, size: 6),
                SizedBox(width: 5),
                Flexible(
                  child: Container(
                    //Check if theres a 'url' provided in Firebase
                    child: document['url'] == null || document['url'] == ''
                        ? Text(
                            '${document['text']}',
                            style: Body2TextStyle.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(58, 66, 86, 0.9),
                              fontSize: 15,
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                ChapterTabs.id,
                                arguments: Chapters(
                                    checkListName: checklistName,
                                    chapterName: document['url']),
                              );
                            },
                            child: Text(
                              '${document['text']}',
                              style: Body2TextStyle.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.blue,
                                fontSize: 15,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
          ],
        );
}
