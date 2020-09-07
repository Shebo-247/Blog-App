import 'package:flutter/material.dart';

const String welcomePage = 'welcomePage';
const String signUpPage = 'signUpPage';
const String signInPage = 'signInPage';
const String homePage = 'homePage';
const String profilePage = 'profilePage';
const String articlesPage = 'articlesPage';
const String addArticlePage = 'addArticlePage';

const String SERVER_URL = 'http://192.168.1.4:5000';

ThemeData appTheme = ThemeData(
  fontFamily: 'BukraRegular',
  primaryColor: Colors.lightGreen[400],
  primaryColorDark: Colors.green[900],
);

const kLinearGradient = LinearGradient(
  colors: [
    Colors.white,
    Colors.green,
  ],
  begin: FractionalOffset(0.0, 1.0),
  end: FractionalOffset(0.0, 1.0),
  stops: [0.0, 1.0],
  tileMode: TileMode.repeated,
);
