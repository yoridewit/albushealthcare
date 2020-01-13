import 'package:albus/screens/register.dart';
import 'package:albus/screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Theme.of(context).primaryColor));

    if (showSignIn) {
      return SignIn(toggleViewFunction: toggleView);
    } else {
      return Register(toggleViewFunction: toggleView);
    }
  }
}
