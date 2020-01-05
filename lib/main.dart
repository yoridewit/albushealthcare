import 'package:albus/constants/style.dart';
import 'package:albus/providers/weights.dart';
import 'package:albus/screens/chapter.dart';
import 'package:albus/screens/chapter_index.dart';
import 'package:albus/screens/chapter_tabs.dart';
import 'package:albus/screens/home.dart';
import 'package:albus/screens/weight_settings_panel.dart';
import 'package:albus/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './services/database.dart';
import './models/checklists.dart';

void main() => runApp(Provider<int>.value(
      value: 0,
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Weights(),
      child: StreamProvider<List<Checklist>>.value(
        value: DatabaseService().checklists,
        child: MaterialApp(
          home: Wrapper(),
          routes: {
            ChapterIndex.id: (context) => ChapterIndex(),
            Chapter.id: (context) => Chapter(),
            ChapterTabs.id: (context) => ChapterTabs(),
            Home.id: (context) => Home(),
          },
          title: 'Flutter Demo',
          theme: ThemeData(
            fontFamily: 'Roboto',
            primaryColor: Color.fromRGBO(58, 66, 86, 1.0),
            accentColor: Colors.deepOrange,
            primaryColorLight: Colors.blueGrey[100],
            appBarTheme: AppBarTheme(
              textTheme: TextTheme(
                title: AppBarTextStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
