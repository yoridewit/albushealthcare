import 'package:albus/constants/style.dart';
import 'package:albus/screens/chapter.dart';
import 'package:albus/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:albus/widgets/app_bar.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';

class ChapterTabs extends StatelessWidget {
  static const String id = 'chapter_tabs_screen';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Theme.of(context).primaryColor));
    return Scaffold(
      drawer: DrawerWidget(),
      backgroundColor: Theme.of(context).primaryColor,
      appBar: CustomAppBar(title: 'Circulatiestilstand: Niet Schokbaar'),
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () {},
              elevation: 10.0,
              icon: Icon(Icons.add),
              label: Text('KG')),
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
          bottomNavigationBar: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.assignment,
                  color: Colors.white,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.colorize,
                  color: Colors.white,
                ),
              ),
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
