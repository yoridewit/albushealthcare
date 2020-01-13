import 'package:albus/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/authenticate.dart';

import 'models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return user == null ? Authenticate() : Home();
  }
}
