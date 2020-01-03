import 'package:albus/widgets/app_bar.dart';
import 'package:albus/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatelessWidget {
  static const String id = 'home';
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Theme.of(context).primaryColor));

    return Scaffold(
      appBar: CustomAppBar(title: 'Home'),
      drawer: DrawerWidget(),
      body: Container(
        child: Center(
          child: Text('Home screen'),
        ),
      ),
    );
  }
}
