import 'package:albus/constants/style.dart';
import 'package:albus/models/chapters.dart';
import 'package:albus/models/medication_naming.dart';
import 'package:albus/providers/weights.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart';

class Medication extends StatelessWidget {
  static const String id = 'chapter_screen';

  //Get checklistname + chaptername from Chapter_tabs.dart
  final String checkListName;
  final String chapterName;
  Medication({this.checkListName, this.chapterName});

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
              .collection('medication')
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
                  padding: EdgeInsets.only(top: 20),
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
  int tempNumber = Provider.of<Weights>(context).weight;

  MedicationNaming medicationItem = MedicationNaming(
    medicationName: document['medicationName'],
    dosageLow: document['dosageLow'].toDouble(),
    dosageHigh: document['dosageHigh'] != null
        ? document['dosageHigh'].toDouble()
        : null,
    weightClass: document['weightClass'],
    dosageType: document['dosageType'],
    administerType: document['administerType'],
    time: document['time'],
    calculate: document['calculate'],
  );

  calculatedDosage(int tempNumber, double dosageLow, double dosageHigh,
      MedicationNaming medicatinItem) {
    //If there is no high dosage given and no weight entered for calculation
    if (dosageHigh == null && tempNumber == null) {
      return dosageLow;
    }
    if (dosageHigh == null && medicationItem.calculate == false) {
      return dosageLow;
    }
    //If there is no high dosage given and there is NOT a weight entered for calculation
    if (dosageHigh != null && tempNumber == null) {
      return '$dosageLow - $dosageHigh';
    }
    //If there is no high dosage given but theres IS a weight entered for calculation
    if (dosageHigh == null) {
      double calculatedLow = tempNumber * dosageLow;
      String calculatedRounded = calculatedLow.toStringAsFixed(2);
      return calculatedRounded;

      //If there IS a high dosage given AND theres a number entered for calculation
    } else {
      double calculatedLow = tempNumber * dosageLow;
      double calculatedHigh = tempNumber * dosageHigh;
      String calculatededRounded =
          '${calculatedLow.toStringAsFixed(2)} - ${calculatedHigh.toStringAsFixed(2)}';
      return calculatededRounded;
    }
  }

  formulateStringNoCalculation(MedicationNaming medicationItem) {
    String stringReturn;

    //A: if theres is no time additive entered (aka /uur of /min) dont add it to the string
    if (medicationItem.time == null) {
      stringReturn =
          '${calculatedDosage(tempNumber, medicationItem.dosageLow, medicationItem.dosageHigh, medicationItem)} ${medicationItem.weightClass}${medicationItem.dosageType} ${medicationItem.administerType} ';
    }
    //B: if theres IS time additive entered (aka /uur of /min) add it to the string
    if (medicationItem.time != null) {
      stringReturn =
          '${calculatedDosage(tempNumber, medicationItem.dosageLow, medicationItem.dosageHigh, medicationItem)} ${medicationItem.weightClass}${medicationItem.dosageType}${medicationItem.time} ${medicationItem.administerType} ';
    }
    return stringReturn;
  }

  formulateStringWithCalculation(MedicationNaming medicationItem) {
    String stringReturn;
    //C
    if (medicationItem.time == null) {
      stringReturn =
          '${calculatedDosage(tempNumber, medicationItem.dosageLow, medicationItem.dosageHigh, medicationItem)} ${medicationItem.weightClass} ${medicationItem.administerType} ';
    }
    //D
    if (medicationItem.time != null) {
      stringReturn =
          '${calculatedDosage(tempNumber, medicationItem.dosageLow, medicationItem.dosageHigh, medicationItem)} ${medicationItem.weightClass}${medicationItem.time} ${medicationItem.administerType} ';
    }
    return stringReturn;
  }

  return tempNumber == null
      ? Card(
          elevation: 0.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration:
                BoxDecoration(color: Theme.of(context).primaryColorLight),
            child: Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      document['medicationName'],
                      style: Body1TextStyle,
                    ),
                    Text(
                      formulateStringNoCalculation(medicationItem),
                      style: Body1TextStyle,
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      : Card(
          elevation: 0.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.deepOrange[400]),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        document['medicationName'],
                        style: Body1TextStyle,
                      ),
                    ),
                    Text(
                      formulateStringWithCalculation(medicationItem),
                      style: Body1TextStyle,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
}
