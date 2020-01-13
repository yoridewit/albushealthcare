import '../models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on firebaser user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream (with mapping FireBasUser to custom user class)
  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  //sign in with email +pw
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email+pw
  Future registerWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //transform FireBase user to our own User info via User model method
      FirebaseUser user = result.user;

      //create a new document for the user with the uid
      await DatabaseService(uid: user.uid).createUser(name);
      await DatabaseService(uid: user.uid)
          .createUserSubscribedDefault('hagaziekenhuis_OK_volwassenen');
      await DatabaseService(uid: user.uid).createUserOwnedDefault('');

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print('error: ' + e.toString());
    }
  }
}
