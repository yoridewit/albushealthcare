import 'package:albus/animation/FadeInAnimation.dart';
import 'package:albus/constants/style.dart';
import 'package:albus/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../services/auth.dart';
import 'package:password_strength/password_strength.dart';

class Register extends StatefulWidget {
  //accept toggleViewFunction from authenticate.dart
  final Function toggleViewFunction;
  Register({this.toggleViewFunction});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final passWordValidator = MultiValidator([
    RequiredValidator(errorText: 'Please enter a password'),
    MinLengthValidator(8,
        errorText: 'Password must be at least 8 characters long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'Password must contain a special character'),
    PatternValidator(r'[A-Z]',
        errorText: 'Password must contain an uppercase character')
  ]);
  bool passwordMinLength = false;
  bool passwordSpecialCharacter = false;
  bool passwordUpperCaseCharacter = false;

  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String passwordCheck = '';
  String name = '';
  String error = '';
  bool showPasswordField = false;

  void togglePasswordField() {
    setState(() => showPasswordField = !showPasswordField);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Theme.of(context).primaryColor));

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: CustomAppBar(title: '', icon: null),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: loading
            ? SpinKitCircle(
                color: Theme.of(context).accentColor,
              )
            : Container(
                child: Column(
                  children: <Widget>[
                    // FadeAnimation(
                    //   0.5,
                    //   Image.asset(
                    //     'assets/logo_white.png',
                    //     width: 100,
                    //   ),
                    // ),
                    SizedBox(
                      height: 20,
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 30.0),
                              decoration: BoxDecoration(
                                border: Border.all(width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white,
                              ),
                              child: showPasswordField == false
                                  //Name + Email box
                                  ? Column(
                                      children: <Widget>[
                                        Text(
                                          'Register',
                                          style: Body1TextStyle.copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 24.0),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Container(
                                          child: FadeAnimation(
                                            1,
                                            TextFormField(
                                              decoration:
                                                  buildInputDecorationFormat(
                                                      context, 'Name'),
                                              validator: (val) => val.isEmpty
                                                  ? 'Please enter your name'
                                                  : null,
                                              onChanged: (val) {
                                                setState(() => name = val);
                                              },
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          child: FadeAnimation(
                                            1.2,
                                            TextFormField(
                                              decoration:
                                                  buildInputDecorationFormat(
                                                      context, 'E-mail adress'),
                                              validator: EmailValidator(
                                                  errorText:
                                                      'Enter a valid e-mail adress'),
                                              onChanged: (val) {
                                                setState(() => email = val);
                                              },
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        FadeAnimation(
                                          1.4,
                                          RaisedButton(
                                            child: Text('Next',
                                                style: Body1TextStyle),
                                            onPressed: () {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                setState(() =>
                                                    togglePasswordField());
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
                                              'Already a member? Sign in',
                                              style: Body1TextStyle.copyWith(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                            onTap: () {
                                              widget.toggleViewFunction();
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  //Password box
                                  : Column(
                                      children: <Widget>[
                                        Text(
                                          'Register',
                                          style: Body1TextStyle.copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 24.0),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        FadeAnimation(
                                          0.5,
                                          TextFormField(
                                            decoration:
                                                buildInputDecorationFormat(
                                                    context, 'Password'),
                                            validator: passWordValidator,
                                            obscureText: true,
                                            onChanged: (val) {
                                              setState(() {
                                                password = val;
                                                setState(() {
                                                  passwordCheck = val;
                                                  if (val.contains(RegExp(
                                                      r'(?=.*?[#?!@$%^&*-])'))) {
                                                    passwordSpecialCharacter =
                                                        true;
                                                  }
                                                  if (!val.contains(RegExp(
                                                      r'(?=.*?[#?!@$%^&*-])'))) {
                                                    passwordSpecialCharacter =
                                                        false;
                                                  }
                                                  if (val.contains(
                                                      RegExp(r'[A-Z]'))) {
                                                    passwordUpperCaseCharacter =
                                                        true;
                                                  }
                                                  if (!val.contains(
                                                      RegExp(r'[A-Z]'))) {
                                                    passwordUpperCaseCharacter =
                                                        false;
                                                  }
                                                  if (val.length >= 8) {
                                                    passwordMinLength = true;
                                                  }
                                                  if (val.length < 8) {
                                                    passwordMinLength = false;
                                                  }
                                                });
                                              });
                                            },
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        FadeAnimation(
                                          0.7,
                                          TextFormField(
                                            decoration:
                                                buildInputDecorationFormat(
                                                    context,
                                                    'Re-enter password'),
                                            validator: (val) => val != password
                                                ? 'Passwords don\'t match'
                                                : null,
                                            obscureText: true,
                                            onChanged: (val) {},
                                          ),
                                        ),
                                        Text(
                                          error,
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 14),
                                        ),
                                        FadeAnimation(
                                          0.9,
                                          Column(children: <Widget>[
                                            passwordMinLength
                                                ? Text('More than 8 characters',
                                                    style: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        color:
                                                            Colors.green[500]))
                                                : Text('More than 8 characters',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .redAccent[100])),
                                            passwordUpperCaseCharacter
                                                ? Text(
                                                    'At least 1 upper case character',
                                                    style: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        color:
                                                            Colors.green[500]))
                                                : Text(
                                                    'At least 1 upper case character',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .redAccent[100])),
                                            passwordSpecialCharacter
                                                ? Text(
                                                    'At least 1 special character',
                                                    style: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        color:
                                                            Colors.green[500]))
                                                : Text(
                                                    'At least 1 special character',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .redAccent[100])),
                                          ]),
                                        ),
                                        SizedBox(height: 10),
                                        FadeAnimation(
                                          1,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              RaisedButton(
                                                color: Colors.grey[300],
                                                child: Text('Back',
                                                    style:
                                                        Body1TextStyle.copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor)),
                                                onPressed: () {
                                                  //back to email + pw
                                                  togglePasswordField();
                                                },
                                              ),
                                              RaisedButton(
                                                child: Text('Register',
                                                    style: Body1TextStyle),
                                                onPressed: () async {
                                                  //register
                                                  if (_formKey.currentState
                                                      .validate()) {
                                                    setState(
                                                        () => loading = true);
                                                    dynamic result = await _auth
                                                        .registerWithEmailAndPassword(
                                                            email,
                                                            password,
                                                            name);
                                                    if (result == null) {
                                                      setState(() {
                                                        error =
                                                            'Error signing up';
                                                        loading = false;
                                                      });
                                                    }
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        FadeAnimation(
                                          1.1,
                                          InkWell(
                                            child: Text(
                                              'Sign in',
                                              style: Body1TextStyle.copyWith(
                                                  color: Theme.of(context)
                                                      .primaryColor),
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
      ),
    );
  }

  passwordStrengthString(double passwordStrength) {
    if (passwordStrength == 0) {
      return '';
    }
    if (passwordStrength >= 0 && passwordStrength < 0.7) {
      return 'Password not strong enough';
    }
    if (passwordStrength >= 0 && passwordStrength >= 0.7) {
      return 'Password strong enough';
    }
  }

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

//register
