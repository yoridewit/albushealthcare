import 'package:albus/constants/style.dart';
import 'package:albus/models/checklists.dart';
import 'package:albus/screens/home.dart';
import 'package:albus/widgets/checklist_tile_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/checklists.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final checklists = Provider.of<List<Checklist>>(context) ?? [];

    return new Drawer(
        child: Container(
      color: Color(0xFFF3F5F7),
      child: new ListView(
        children: <Widget>[
          new DrawerHeader(
            child: Center(
              child: new Text(
                "ALBUS",
                style: TitleTextStyle,
              ),
            ),
            decoration: new BoxDecoration(color: Colors.deepOrange),
          ),
          new ListTile(
            leading: Icon(Icons.home),
            title: new Text(
              "Home",
              style: Body1TextStyle.copyWith(color: Colors.grey[800]),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, Home.id);
            },
          ),
          ExpansionTile(
            backgroundColor: Colors.grey[200],
            leading: Icon(Icons.menu),
            title: Text(
              'Spoedbundels',
              style: Body1TextStyle.copyWith(color: Colors.grey[800]),
            ),
            children: <Widget>[
              ListView.builder(
                shrinkWrap: true,
                itemCount: checklists.length,
                itemBuilder: (context, index) {
                  return ChecklistTileDrawer(checklist: checklists[index]);
                },
              )
            ],
          ),
          new ListTile(
            leading: Icon(Icons.email),
            title: new Text(
              "Contact",
              style: Body1TextStyle.copyWith(color: Colors.grey[800]),
            ),
            onTap: () {
              //different route option
            },
          ),
        ],
      ),
    ));
  }
}
