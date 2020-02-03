import 'package:albus/constants/style.dart';
import 'package:albus/providers/weights.dart';
import 'package:albus/screens/chapter.dart';
import 'package:albus/screens/chapter_index.dart';
import 'package:albus/screens/chapter_tabs.dart';
import 'package:albus/screens/contact.dart';
import 'package:albus/services/auth.dart';
import 'package:albus/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import './services/database.dart';
import './models/checklists.dart';
import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

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
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case ChapterIndex.id:
                  return PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: ChapterIndex(settings.arguments));
                  break;
                case ChapterTabs.id:
                  return PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: ChapterTabs(settings.arguments));
                  break;
                case Wrapper.id:
                  return PageTransition(
                      type: PageTransitionType.leftToRight, child: Wrapper());
                  break;
                case Chapter.id:
                  return PageTransition(
                      type: PageTransitionType.leftToRight, child: Chapter());
                  break;
                case Contact.id:
                  return PageTransition(
                      type: PageTransitionType.rightToLeft, child: Contact());
                  break;
              }
            },
            debugShowCheckedModeBanner: false,
            home: Wrapper(),
            routes: {
              // ChapterIndex.id: (context) => ChapterIndex(),
              // Chapter.id: (context) => Chapter(),
              // ChapterTabs.id: (context) => ChapterTabs(),
              // Home.id: (context) => Home(),
            },
            title: 'Albus Healthcare',
            theme: ThemeData(
              // scaffoldBackgroundColor: Color(0xFFF3F5F7),
              scaffoldBackgroundColor: Color.fromRGBO(81, 89, 110, 1.0),
              buttonColor: Colors.red,
              fontFamily: 'Roboto',
              primaryColor: Color.fromRGBO(58, 66, 86, 1.0),
              accentColor: Colors.red,
              primaryColorLight: Color.fromRGBO(64, 75, 96, .9),
              primaryColorDark: Colors.black,
              cardColor: Color(0xFFF3F5F7),
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

// Old dark theme data
// ThemeData(
//               scaffoldBackgroundColor: Color.fromRGBO(58, 66, 86, 1.0),

//               buttonColor: Colors.deepOrange,
//               fontFamily: 'Roboto',
//               primaryColor: Color.fromRGBO(58, 66, 86, 1.0),
//               accentColor: Colors.deepOrange,
//               primaryColorLight: Color.fromRGBO(64, 75, 96, .9),
//               cardColor: Color(0xFFF3F5F7),
//               appBarTheme: AppBarTheme(
//                 textTheme: TextTheme(
//                   title: AppBarTextStyle,
//                 ),
//               ),
//             ),
