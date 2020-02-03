import 'package:flutter/material.dart';

const String FontNameCondensed = 'RobotoCondensed';
const String FontNameDefault = 'Raleway';

const LargeTextSize = 26.0;
const MediumTextSize = 20.0;
const BodyTextSize = 16.0;
const SubtextSize = 14.0;

const AppBarTextStyle = TextStyle(
  fontFamily: FontNameDefault,
  fontWeight: FontWeight.w400,
  fontSize: MediumTextSize,
);

const TitleTextStyle = TextStyle(
  fontFamily: FontNameDefault,
  fontWeight: FontWeight.w900,
  fontSize: LargeTextSize,
  color: Colors.white,
);

const Body1TextStyle = TextStyle(
    fontFamily: FontNameDefault,
    fontSize: BodyTextSize,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    letterSpacing: 0.4);

const Body2TextStyle = TextStyle(
  fontFamily: FontNameCondensed,
  fontWeight: FontWeight.w100,
  fontSize: SubtextSize,
  color: Colors.white,
);

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  disabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color.fromRGBO(58, 66, 86, 1.0),
      width: 1,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.deepOrange,
      width: 1,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.deepOrange,
      width: 2,
    ),
  ),
);
