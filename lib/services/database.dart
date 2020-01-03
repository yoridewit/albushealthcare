import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/checklists.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference chapterCollection =
      Firestore.instance.collection('userbase');

  //Chapter List from snapshot
  List<Checklist> _chapterListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Checklist(
          title: doc.data['title'] ?? 'Default title',
          docName: doc.documentID.toString());
    }).toList();
  }

  //Get chapters stream
  Stream<List<Checklist>> get checklists {
    return chapterCollection.snapshots().map(_chapterListFromSnapshot);
  }
}
