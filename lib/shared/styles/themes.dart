import 'package:flutter/material.dart';
import 'package:shop_app/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.orange,
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'Jannah ',
  textTheme: TextTheme(headline2: TextStyle(color: Colors.black, fontSize: 24), bodyText1: TextStyle(color: Colors.black, fontSize: 18)),
  appBarTheme: AppBarTheme(
    backwardsCompatibility: false,
    color: Colors.white,
    elevation: 0.0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    unselectedItemColor: greyColor,
    elevation: 5.0,
    type: BottomNavigationBarType.fixed,



  ),
);
