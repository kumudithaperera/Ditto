import 'package:ditto/helper/enums.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'colors.dart';

ThemeData pink  = ThemeData(
  primaryColor: primaryColorBasic,
  backgroundColor: SecondaryColorBasic,
  primaryTextTheme: TextTheme(
    button: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  ),
);

ThemeData blue = ThemeData(
  primaryColor: PrimaryColorBlue,
  backgroundColor: SecondaryColorBlue,
  appBarTheme: AppBarTheme(
      color: AppBarColorBlue,
  ),
  primaryTextTheme: TextTheme(
    button: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  ),
);

ThemeData green = ThemeData(
  primaryColor: PrimaryColorGreen,
  backgroundColor: SecondaryColorGreen,
  appBarTheme: AppBarTheme(
      color: AppBarColorGreen,
  ),
  primaryTextTheme: TextTheme(
    button: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  ),
);

ThemeData gold = ThemeData(
  primaryColor: PrimaryColorGold,
  backgroundColor: SecondaryColorGold,
  appBarTheme: AppBarTheme(
      color: AppBarColorGold,
  ),
  primaryTextTheme: TextTheme(
    button: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  ),
);

ThemeData orange = ThemeData(
  primaryColor: PrimaryColorOrange,
  backgroundColor: SecondaryColorOrange,
  appBarTheme: AppBarTheme(
      color: AppBarColorOrange,
  ),
  primaryTextTheme: TextTheme(
    button: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  ),
);


class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  SharedPreferences prefs;
  ThemeData currentTheme = pink;
  String logoPath = "assets/images/logo.svg";


  themeNotifier(String type){
    if(type == PersonalityTypes.ENFJ.toString() || type == PersonalityTypes.INFJ.toString() || type == PersonalityTypes.ENFP.toString() || type == PersonalityTypes.INFP.toString()){
      // green
      currentTheme = green;
      logoPath = 'assets/images/green.svg';
      notifyListeners();
    }
    if(type == PersonalityTypes.INTJ.toString() || type == PersonalityTypes.ENTJ.toString() || type == PersonalityTypes.INTP.toString() || type == PersonalityTypes.ENTP.toString()){
      // Blue
      currentTheme = blue;
      logoPath = 'assets/images/blue.svg';
      notifyListeners();
    }
    if(type == PersonalityTypes.ESFJ.toString() || type == PersonalityTypes.ISFP.toString() || type == PersonalityTypes.ESFJ.toString() || type == PersonalityTypes.ISFJ.toString()){
      // Yellow
      currentTheme = gold;
      logoPath = 'assets/images/gold.svg';
      notifyListeners();
    }
    if(type == PersonalityTypes.ISTP.toString() || type == PersonalityTypes.ESTP.toString() || type == PersonalityTypes.ISTJ.toString() || type == PersonalityTypes.ESTJ.toString()){
      // orange
      currentTheme = orange;
      logoPath = 'assets/images/orange.svg';
      notifyListeners();
    }
  }
}