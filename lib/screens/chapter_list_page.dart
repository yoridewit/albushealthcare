import 'package:albus/constants/style.dart';
import 'package:albus/widgets/app_bar.dart';
import 'package:albus/widgets/drawer_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChapterListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: CustomAppBar(
        title: 'Checklist',
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
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
                },
              );
            }),
      ),
    );
  }
}

Widget _buildList(BuildContext context, DocumentSnapshot document) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 15.0),
    child: Text(
      document['title'],
      style: Body2TextStyle,
    ),
  );
}
