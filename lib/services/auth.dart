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
    String errorMessage;
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          return errorMessage = "Invalid email adress";
          break;
        case "ERROR_WRONG_PASSWORD":
          return errorMessage = "Oops. Wrong password";
          break;
        case "ERROR_USER_NOT_FOUND":
          return errorMessage = "User with this email does not exist";
          break;
        case "ERROR_USER_DISABLED":
          return errorMessage = "User with this email has been disabled";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          return errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          return errorMessage =
              "Signing in with Email and Password is not enabled.";
          break;
        default:
          return errorMessage = "An undefined Error happened.";
      }
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
      print('signed out');
      return await _auth.signOut();
    } catch (e) {
      print('error: ' + e.toString());
    }
  }
}
