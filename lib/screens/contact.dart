import 'package:albus/constants/strings.dart';
import 'package:albus/constants/style.dart';
import 'package:albus/widgets/app_bar.dart';
import 'package:albus/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  static const String id = 'contact_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: CustomAppBar(
        title: 'Contact',
        icon: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              SizedBox(height: 24),
              Text('Albus Healthcare',
                  style: Body1TextStyle.copyWith(fontSize: 36)),
              SizedBox(height: 10),
              Text('Easy and effective crisis checklist management',
                  style: Body1TextStyle),
              SizedBox(height: 20),
              Divider(
                indent: 20,
                color: Theme.of(context).accentColor,
                thickness: 1,
              ),
              //First question
              SizedBox(height: 10),
              Container(
                color: Color(0xFFF3F5F7),
                child: ExpansionTile(
                  backgroundColor: Color(0xFFF3F5F7),
                  title: Text(
                    contactPageQuestion01,
                    style: Body1TextStyle.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontStyle: FontStyle.italic),
                  ),
                  children: <Widget>[
                    ListTile(
                      title: Text(contactPageAnswer01,
                          style: Body1TextStyle.copyWith(
                              color: Theme.of(context).primaryColor)),
                    ),
                  ],
                ),
              ),
              //Second question
              SizedBox(height: 10),
              Container(
                color: Color(0xFFF3F5F7),
                child: ExpansionTile(
                  backgroundColor: Color(0xFFF3F5F7),
                  title: Text(
                    contactPageQuestion01,
                    style: Body1TextStyle.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontStyle: FontStyle.italic),
                  ),
                  children: <Widget>[
                    ListTile(
                      title: Text(contactPageAnswer01,
                          style: Body1TextStyle.copyWith(
                              color: Theme.of(context).primaryColor)),
                    ),
                  ],
                ),
              ),
              //Third question
              SizedBox(height: 10),
              Container(
                color: Color(0xFFF3F5F7),
                child: ExpansionTile(
                  backgroundColor: Color(0xFFF3F5F7),
                  title: Text(
                    contactPageQuestion01,
                    style: Body1TextStyle.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontStyle: FontStyle.italic),
                  ),
                  children: <Widget>[
                    ListTile(
                      title: Text(contactPageAnswer01,
                          style: Body1TextStyle.copyWith(
                              color: Theme.of(context).primaryColor)),
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[],
              )
            ],
          ),
        ),
      ),
    );
  }
}
