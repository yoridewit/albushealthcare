import 'package:albus/constants/style.dart';
import 'package:albus/providers/weights.dart';
import 'package:albus/screens/chapter.dart';
import 'package:albus/screens/chapter_index.dart';
import 'package:albus/screens/chapter_tabs.dart';
import 'package:albus/screens/home.dart';
import 'package:albus/screens/weight_settings_panel.dart';
import 'package:albus/services/auth.dart';
import 'package:albus/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './services/database.dart';
import './models/checklists.dart';
import 'models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: ChangeNotifierProvider(
        create: (ctx) => Weights(),
        child: StreamProvider<List<Checklist>>.value(
          value: DatabaseService().checklists,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Wrapper(),
            routes: {
              ChapterIndex.id: (context) => ChapterIndex(),
              Chapter.id: (context) => Chapter(),
              ChapterTabs.id: (context) => ChapterTabs(),
              Home.id: (context) => Home(),
            },
            title: 'Flutter Demo',
            theme: ThemeData(
              buttonColor: Colors.deepOrange,
              fontFamily: 'Roboto',
              primaryColor: Color.fromRGBO(58, 66, 86, 1.0),
              accentColor: Colors.deepOrange,
              primaryColorLight: Color.fromRGBO(64, 75, 96, .9),
              appBarTheme: AppBarTheme(
                textTheme: TextTheme(
                  title: AppBarTextStyle,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
