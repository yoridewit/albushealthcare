import 'package:albus/animation/FadeInAnimation.dart';
import 'package:albus/constants/style.dart';
import 'package:albus/models/checklists.dart';
import 'package:albus/services/auth.dart';
import 'package:albus/widgets/app_bar.dart';
import 'package:albus/widgets/checklist_tile_home.dart';
import 'package:albus/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  static const String id = 'home';
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final checklists = Provider.of<List<Checklist>>(context) ?? [];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: 'Home',
        icon: IconButton(
          icon: Icon(Icons.exit_to_app),
          color: Colors.white,
          onPressed: () async {
            await _auth.signOut();
          },
        ),
      ),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Image.asset(
                'assets/logo_white.png',
                width: screenWidth > 500 ? 200 : 100,
              ),
              SizedBox(height: 50),
              FadeAnimation(
                0.2,
                Text(
                  'Subscribed Checklists',
                  style: Body1TextStyle.copyWith(fontSize: 24),
                ),
              ),
              FadeAnimation(
                0.2,
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Divider(
                    thickness: 1,
                    endIndent: screenWidth > 500 ? 200 : 40,
                    indent: screenWidth > 500 ? 200 : 40,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
              FadeAnimation(
                0.4,
                Container(
                  width: screenWidth > 500 ? 550 : 320,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFFF3F5F7),
                  ),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      endIndent: screenWidth > 500 ? 150 : 40,
                      indent: screenWidth > 500 ? 150 : 40,
                      color: Theme.of(context).primaryColor,
                    ),
                    shrinkWrap: true,
                    itemCount: checklists.length,
                    itemBuilder: (context, index) {
                      return ChecklistTileHome(
                        checklist: checklists[index],
                      );
                    },
                  ),
                ),
              ),
              FadeAnimation(
                0.6,
                IconButton(
                  icon: Icon(Icons.add),
                  color: Color(0xFFF3F5F7),
                  onPressed: () {},
                  iconSize: 36,
                ),
              ),
              FadeAnimation(
                0.6,
                Divider(
                  thickness: 1,
                  endIndent: screenWidth > 500 ? 200 : 40,
                  indent: screenWidth > 500 ? 200 : 40,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
