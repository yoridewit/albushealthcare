import 'package:albus/constants/style.dart';
import 'package:albus/providers/weights.dart';
import 'package:albus/screens/chapter.dart';
import 'package:albus/screens/weight_settings_panel.dart';
import 'package:albus/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:albus/widgets/app_bar.dart';
import 'package:provider/provider.dart';

class ChapterTabs extends StatelessWidget {
  static const String id = 'chapter_tabs_screen';

  @override
  Widget build(BuildContext context) {
    int tempNumber = Provider.of<Weights>(context).weight;
    print('$tempNumber from Chapter Tabs');

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

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Theme.of(context).primaryColor));
    return Scaffold(
      drawer: DrawerWidget(),
      backgroundColor: Theme.of(context).primaryColor,
      appBar: CustomAppBar(title: 'Chapter Index'),
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                tempNumber == null
                    ? _showWeightPanel()
                    : Provider.of<Weights>(context).deleteValue();
              },
              elevation: 10.0,
              icon: tempNumber == null
                  ? Icon(Icons.add)
                  : Icon(Icons.delete_forever),
              label: Text(
                tempNumber == null ? 'KG' : '$tempNumber KG',
                style: Body1TextStyle,
              )),
          body: TabBarView(
            children: <Widget>[
              Chapter(),
              Container(
                color: Theme.of(context).primaryColor,
                child: Center(
                  child: Text(
                    'Medication Screen',
                    style: Body1TextStyle,
                  ),
                ),
              ),
              Container(
                color: Theme.of(context).primaryColor,
                child: Center(
                  child: Text(
                    'DDx Screen',
                    style: Body1TextStyle,
                  ),
                ),
              ),
            ],
          ),
          //CONTENT
          bottomNavigationBar: TabBar(
            tabs: <Widget>[
              //FIRST TAB
              Tab(
                icon: Icon(
                  Icons.assignment,
                  color: Colors.white,
                ),
              ),
              //SECOND TAB
              Tab(
                icon: Icon(
                  Icons.colorize,
                  color: Colors.white,
                ),
              ),
              //THIRD TAB
              Tab(
                icon: Icon(
                  Icons.help,
                  color: Colors.white,
                ),
              ),
            ],
            unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(5.0),
            indicatorColor: Colors.red,
            indicatorWeight: 4.0,
          ),
        ),
      ),
    );
  }
}
