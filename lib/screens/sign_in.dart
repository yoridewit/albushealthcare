import 'package:albus/animation/FadeInAnimation.dart';
import 'package:albus/constants/style.dart';
import 'package:albus/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../services/auth.dart';

class SignIn extends StatefulWidget {
  //accept toggleViewFunction from authenticate.dart
  final Function toggleViewFunction;
  SignIn({this.toggleViewFunction});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Theme.of(context).primaryColor));
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: CustomAppBar(title: '', icon: null),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            FadeAnimation(
              0.5,
              Image.asset(
                'assets/logo_white.png',
                width: 100,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  FadeAnimation(
                    0.7,
                    Container(
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                      ),
                      child: loading
                          ? SpinKitRing(
                              color: Theme.of(context).accentColor,
                            )
                          : Column(
                              children: <Widget>[
                                Text(
                                  'Sign In',
                                  style: Body1TextStyle.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 24.0),
                                ),
                                SizedBox(height: 10),
                                FadeAnimation(
                                  1,
                                  TextFormField(
                                    decoration: buildInputDecorationFormat(
                                        context, 'E-mail adress'),
                                    validator: (val) => val.isEmpty
                                        ? 'Enter a valid email'
                                        : null,
                                    onChanged: (val) {
                                      setState(() => email = val);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                FadeAnimation(
                                  1.2,
                                  TextFormField(
                                    decoration: buildInputDecorationFormat(
                                        context, 'Password'),
                                    validator: (val) => val.length < 6
                                        ? 'Password must at least be 6 characters'
                                        : null,
                                    obscureText: true,
                                    onChanged: (val) {
                                      //password
                                      setState(() => password = val);
                                    },
                                  ),
                                ),
                                SizedBox(height: 5),
                                FadeAnimation(
                                  1.2,
                                  Text(
                                    error,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 14),
                                  ),
                                ),
                                FadeAnimation(
                                  1.4,
                                  RaisedButton(
                                    child:
                                        Text('Sign In', style: Body1TextStyle),
                                    onPressed: () async {
                                      //sign in
                                      if (_formKey.currentState.validate()) {
                                        setState(() => loading = true);
                                        dynamic result = await _auth
                                            .signInWithEmailAndPassword(
                                                email, password);
                                        if (result == null) {
                                          if (mounted) {
                                            setState(() {
                                              loading = false;
                                              error =
                                                  'Login failed, check credentials';
                                            });
                                          }
                                        }
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                FadeAnimation(
                                  1.6,
                                  InkWell(
                                    child: Text(
                                      'Register',
                                      style: Body1TextStyle.copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    onTap: () {
                                      widget.toggleViewFunction();
                                    },
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Input decoration for formfields
  InputDecoration buildInputDecorationFormat(
      BuildContext context, String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle:
          Body1TextStyle.copyWith(color: Theme.of(context).primaryColor),
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey[300],
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey[300],
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).accentColor,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.redAccent,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
