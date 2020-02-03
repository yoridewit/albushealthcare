import 'package:albus/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/authenticate.dart';

import 'models/user.dart';

class Wrapper extends StatefulWidget {
  static const String id = 'wrapper';
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return user == null ? Authenticate() : Home();
  }
}
