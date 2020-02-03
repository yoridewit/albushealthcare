import 'package:albus/constants/style.dart';
import 'package:albus/models/chapters.dart';
import 'package:albus/models/checklists.dart';
import 'package:albus/providers/documents.dart';
import 'package:albus/providers/weights.dart';
import 'package:albus/screens/chapter.dart';
import 'package:albus/screens/ddx.dart';
import 'package:albus/screens/medication.dart';
import 'package:albus/screens/weight_settings_panel.dart';
import 'package:albus/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:albus/widgets/app_bar.dart';
import 'package:provider/provider.dart';

class ChapterTabs extends StatefulWidget {
  static const String id = 'chapter_tabs_screen';
  final Chapters chapterInfo;
  ChapterTabs(this.chapterInfo);

  @override
  _ChapterTabsState createState() => _ChapterTabsState();
}

class _ChapterTabsState extends State<ChapterTabs> {
  @override
  Widget build(BuildContext context) {
    int tempNumber = Provider.of<Weights>(context).weight;
    Chapters chapterInfo = widget.chapterInfo;
    String checkListName = chapterInfo.checkListName;
    String chapterName = chapterInfo.chapterName;

    void _showWeightPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: WeightPanel(),
            );
          });
    }

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).scaffoldBackgroundColor));
    return ChangeNotifierProvider(
      create: (ctx) => Documents(),
      child: Scaffold(
        drawer: DrawerWidget(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: CustomAppBar(
          title: chapterName,
          icon: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  tempNumber == null
                      ? _showWeightPanel()
                      : Provider.of<Weights>(context).deleteValue();
                },
                elevation: 10.0,
                icon: AnimatedCrossFade(
                  duration: Duration(milliseconds: 300),
                  firstChild: Icon(Icons.add),
                  secondChild: Icon(Icons.delete_forever),
                  crossFadeState: _checkWeightForNull(tempNumber)
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                ),
                label: Text(
                  tempNumber == null ? 'KG' : '$tempNumber KG',
                  style: Body1TextStyle.copyWith(color: Colors.white),
                )),
            body: TabBarView(
              children: <Widget>[
                //pass values from chapter_index's modal route via the Chapters model class
                Chapter(
                  chapterName: chapterName,
                  checkListName: checkListName,
                ),
                Medication(
                  chapterName: chapterName,
                  checkListName: checkListName,
                ),
                DDx(
                  chapterName: chapterName,
                  checklistName: checkListName,
                ),
              ],
            ),
            //CONTENT
            bottomNavigationBar: TabBar(
              labelPadding:
                  EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 2),
              tabs: <Widget>[
                //FIRST TAB
                Tab(
                  icon: Icon(
                    Icons.assignment,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                //SECOND TAB
                Tab(
                  icon: Icon(
                    Icons.colorize,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                //THIRD TAB
                Tab(
                  icon: Icon(
                    Icons.help,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ],
              unselectedLabelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorPadding: EdgeInsets.all(5.0),
              indicatorColor: Theme.of(context).accentColor,
              indicatorWeight: 4.0,
            ),
          ),
        ),
      ),
    );
  }
}

_checkWeightForNull(int tempNumber) {
  if (tempNumber == null) {
    return true;
  }
  return false;
}
