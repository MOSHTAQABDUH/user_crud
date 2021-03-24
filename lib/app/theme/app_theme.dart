import 'package:flutter/material.dart';

final ThemeData appThemeData = ThemeData(
    primaryColor: Colors.lightBlue,
    buttonColor: Colors.lightBlue,
    textTheme: TextTheme(bodyText2: TextStyle(color: Colors.black)),
    brightness: Brightness.light,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.lightBlue, foregroundColor: Colors.white),
    accentIconTheme: IconThemeData(color: Colors.white),
    accentColor: Colors.blueAccent,
    appBarTheme: AppBarTheme(
      actionsIconTheme: IconThemeData(color: Colors.white),
      color: Colors.lightBlue,
      textTheme: TextTheme(
        headline6:
            TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'roboto'),
        subtitle1: TextStyle(color: Colors.black),
        bodyText1: TextStyle(color: Colors.black),
      ),
    ));
