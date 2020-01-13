import 'package:albus/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/checklists.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference chapterCollection =
      Firestore.instance.collection('userbase');

  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  Future updateUserName(String name) async {
    return await userCollection.document(uid).setData({'name': name});
  }

  Future updateUserSubscribedChecklists(String subscribedChecklists) async {
    return await userCollection
        .document(uid)
        .collection('subscribedChecklists')
        .document()
        .setData({'checklistDocName': subscribedChecklists});
  }

  Future updateUserOwnedChecklists(String ownedChecklists) async {
    return await userCollection
        .document(uid)
        .collection('ownedChecklists')
        .document()
        .setData({'checklistDocName': ownedChecklists});
  }

  Future createUser(String name) async {
    print('created username');
    return await userCollection.document(uid).setData({
      'name': name,
    });
  }

  Future createUserSubscribedDefault(String subscribedChecklists) async {
    print('trying to create subscr checklist');
    return await userCollection
        .document(uid)
        .collection('subscribedChecklists')
        .document()
        .setData({
      'checklistDocName': subscribedChecklists,
    });
  }

  Future createUserOwnedDefault(String ownedChecklists) async {
    return await userCollection
        .document(uid)
        .collection('ownedChecklists')
        .document()
        .setData({
      'checklistDocName': ownedChecklists,
    });
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      subscribedChecklists: snapshot.data['subscribedTo'],
      ownedChecklists: snapshot.data['ownsChecklists'],
    );
  }

  //Chapter List from snapshot
  List<Checklist> _chapterListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Checklist(
          checklistName: doc.documentID.toString(),
          checkListTitle: doc.data['title'] ?? 'Default title');
    }).toList();
  }

  //Get chapters stream
  Stream<List<Checklist>> get checklists {
    return chapterCollection.snapshots().map(_chapterListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
