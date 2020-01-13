import 'package:albus/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DDx extends StatelessWidget {
  static const String id = 'chapter_screen';

  //Get checklistname + chaptername from Chapter_tabs.dart
  final String checklistName;
  final String chapterName;
  DDx({this.checklistName, this.chapterName});

  @override
  Widget build(BuildContext context) {
    //provide an string that represents the current checklist the user is in to pass to the Chapter_index link in _buildList widget
    //We only need the checkListName, the chapterName will be provided by the user in FireBase
    String currentChecklist = checklistName;

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: Container(
        child: StreamBuilder(
          stream: Firestore.instance
              .collection('userbase')
              .document(checklistName)
              .collection('chapter_index')
              .document(chapterName)
              .collection('ddx')
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
                      currentChecklist, checklistName, chapterName);
                },
              );
            }
          },
        ),
      ),
    );
  }
}

Widget _buildList(BuildContext context, DocumentSnapshot document,
    String currentChecklist, String checklistName, String chapterName) {
  String ddxTitle = document['title'];

  return Card(
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(64, 75, 96, .9),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              ddxTitle,
              style: Body1TextStyle.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Color(0xFFF3F5F7)),
            child: StreamBuilder(
              stream: Firestore.instance
                  .collection('userbase')
                  .document(checklistName)
                  .collection('chapter_index')
                  .document(chapterName)
                  .collection('ddx')
                  .document(ddxTitle)
                  .collection('texts')
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
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      return _buildListCard(
                          context,
                          snapshot.data.documents[index],
                          checklistName,
                          chapterName,
                          ddxTitle);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildListCard(BuildContext context, DocumentSnapshot document,
    String checklistName, String chapterName, String ddxTitle) {
  return Container(
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      child: document['url'] != ''
          ? InkWell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        child: Text(
                          document['text'],
                          overflow: TextOverflow.fade,
                          softWrap: true,
                          style: Body1TextStyle.copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                    Container(
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.blueAccent,
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {},
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Container(
                      child: Text(
                        document['text'],
                        style: Body1TextStyle.copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    ),
  );
}

// return Card(
//     elevation: 8.0,
//     margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
//     child: Container(
//       decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
//       child: ListTile(
//         title: Text(
//           document['title'],
//           style: Body1TextStyle,
//         ),
//         subtitle: Text('test'),
//         trailing: document['url'] == null
//             ? null
//             : Icon(
//                 Icons.arrow_forward,
//                 color: Colors.white,
//               ),
//         onTap: () {
//           Navigator.pushNamed(
//             context,
//             ChapterTabs.id,
//             arguments: Chapters(
//                 checkListName: currentChecklist, chapterName: document['url']),
//           );
//         },
//       ),
//     ),
//   );
