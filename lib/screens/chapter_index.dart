import 'package:albus/constants/style.dart';
import 'package:albus/models/chapters.dart';
import 'package:albus/models/checklists.dart';
import 'package:albus/screens/chapter_tabs.dart';
import 'package:albus/widgets/app_bar.dart';
import 'package:albus/widgets/drawer_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Weight extends ChangeNotifier {
  int currentWeightInKg = 0;

  void changeWeight(int weight) {
    currentWeightInKg = weight;
    notifyListeners();
  }
}

class ChapterIndex extends StatelessWidget {
  static const String id = 'chapter_index_screen';

  @override
  Widget build(BuildContext context) {
    //Get arguments from checklist_tile Navigator through the Checklist class
    final Checklist checklist = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      drawer: DrawerWidget(),
      appBar: CustomAppBar(
        title: checklist.checkListTitle,
        icon: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: StreamBuilder(
            stream: Firestore.instance
                .collection('userbase')
                .document(checklist.checklistName)
                .collection("chapter_index")
                .orderBy('order', descending: false)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return SpinKitCircle(
                  color: Theme.of(context).accentColor,
                );
              }
              if (snapshot.hasError) {
                return Text('Error getting data.');
              }
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return _buildList(
                      context, snapshot.data.documents[index], checklist);
                },
              );
            },
          )),
    );
  }
}

//Create a button with FireBase text
Widget _buildList(
    BuildContext context, DocumentSnapshot document, Checklist checklist) {
  Chapters chapterInfo = Chapters(
      chapterName: document['title'], checkListName: checklist.checklistName);
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15.0),
    child: FlatButton(
      onPressed: () {
        Navigator.pushNamed(context, ChapterTabs.id, arguments: chapterInfo);
      },
      color: Color(0xFFF3F5F7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            document['title'],
            style: Body1TextStyle.copyWith(
                color: Colors.black, fontWeight: FontWeight.w600),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: createColor(document['color']),
          ),
        ],
      ),
    ),
  );
}

//Create a color from FireBase string 'color', only these predifined colors
Color createColor(String color) {
  switch (color) {
    case 'blue':
      {
        return Colors.blue;
      }
      break;
    case 'yellow':
      {
        return Colors.lime[800];
      }
      break;
    case 'green':
      {
        return Colors.green;
      }
      break;
    case 'red':
      {
        return Colors.red;
      }
      break;
    case 'pink':
      {
        return Colors.pink;
      }
      break;
    case 'brown':
      {
        return Colors.brown;
      }
      break;
    case 'orange':
      {
        return Colors.orange;
      }
      break;
    default:
      return Colors.black;
  }
}
