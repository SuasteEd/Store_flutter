import 'package:flutter/material.dart';
class AppTheme {
  static const primary = Color(0xff6482e1);
  static const secondary = Color(0xffb17ad7);

  static final ThemeData ligthTheme = ThemeData.light().copyWith(
    primaryColor: primary,
    //textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.white,  fontFamily: 'Poppins')),
    scaffoldBackgroundColor: primary,
    appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0, backgroundColor: Colors.transparent)
  );
}