import 'package:albus/animation/FadeInAnimation.dart';
import 'package:albus/constants/style.dart';
import 'package:albus/models/checklists.dart';
import 'package:albus/models/user.dart';
import 'package:albus/services/auth.dart';
import 'package:albus/widgets/app_bar.dart';
import 'package:albus/widgets/checklist_tile%20home.dart';
import 'package:albus/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  static const String id = 'home';
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final checklists = Provider.of<List<Checklist>>(context) ?? [];
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Theme.of(context).primaryColor));

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: CustomAppBar(
        title: 'Home',
        icon: IconButton(
          icon: Icon(Icons.person_outline),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  child: Divider(
                    thickness: 1,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
              FadeAnimation(
                0.4,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFF3F5F7),
                    ),
                    child: ListView.separated(
                      separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      shrinkWrap: true,
                      itemCount: checklists.length,
                      itemBuilder: (context, index) {
                        return ChecklistTileHome(checklist: checklists[index]);
                      },
                    ),
                  ),
                ),
              ),
              FadeAnimation(
                0.6,
                IconButton(
                  icon: Icon(Icons.add),
                  color: Colors.white,
                  onPressed: () {},
                  iconSize: 36,
                ),
              ),
              FadeAnimation(
                0.6,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Divider(
                    thickness: 1,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// await DatabaseService(uid: user.uid)
//     .updateUserSubscribedChecklists(
//         'hagaziekenhuis_OK_kinderen');
