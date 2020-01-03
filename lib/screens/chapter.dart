import 'package:albus/constants/style.dart';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Chapter extends StatelessWidget {
  static const String id = 'chapter_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: Container(
        child: StreamBuilder(
          stream: Firestore.instance
              .collection('userbase')
              .document('hagaziekenhuis_OK_volwassenen')
              .collection('chapter_index')
              .document('Circulatiestilstand: Schokbaar')
              .collection('actions')
              .orderBy('order', descending: false)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            {
              if (!snapshot.hasData) {
                return SpinKitCircle(
                  color: Theme.of(context).accentColor,
                );
              }
              if (snapshot.hasError) {
                return Text('error');
              }
              return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return _buildList(context, snapshot.data.documents[index]);
                  });
            }
            ;
          },
        ),
      ),
    );
  }
}

Widget _buildList(BuildContext context, DocumentSnapshot document) {
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
        // trailing: url.isEmpty
        //     ? null
        //     : Icon(
        //         Icons.keyboard_arrow_right,
        //         color: Colors.yellow,
        //       ),
        // onTap: url.isEmpty ? null : () {},
      ),
    ),
  );
}
