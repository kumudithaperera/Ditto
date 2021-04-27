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
  String imagePath = "";


  themeNotifier(String type){
    if(type == PersonalityTypes.ENFJ.toString() || type == PersonalityTypes.INFJ.toString() || type == PersonalityTypes.ENFP.toString() || type == PersonalityTypes.INFP.toString()){
      // green
      currentTheme = green;
      logoPath = 'assets/images/green.svg';
      imagePath = _imagePath(type);
      notifyListeners();
    }
    if(type == PersonalityTypes.INTJ.toString() || type == PersonalityTypes.ENTJ.toString() || type == PersonalityTypes.INTP.toString() || type == PersonalityTypes.ENTP.toString()){
      // Blue
      currentTheme = blue;
      logoPath = 'assets/images/blue.svg';
      imagePath = _imagePath(type);
      notifyListeners();
    }
    if(type == PersonalityTypes.ESFJ.toString() || type == PersonalityTypes.ISFP.toString() || type == PersonalityTypes.ESFJ.toString() || type == PersonalityTypes.ISFJ.toString()){
      // Yellow
      currentTheme = gold;
      logoPath = 'assets/images/gold.svg';
      imagePath = _imagePath(type);
      notifyListeners();
    }
    if(type == PersonalityTypes.ISTP.toString() || type == PersonalityTypes.ESTP.toString() || type == PersonalityTypes.ISTJ.toString() || type == PersonalityTypes.ESTJ.toString()){
      // orange
      currentTheme = orange;
      logoPath = 'assets/images/orange.svg';
      imagePath = _imagePath(type);
      notifyListeners();
    }
  }

  String _imagePath(String type){

    String imagePath = "";

    if(type == PersonalityTypes.INFP.toString()){
      imagePath = "assets/images/personalities/INFP.png";
    }

    if(type == PersonalityTypes.INTJ.toString()){
      imagePath = "assets/images/personalities/INTJ.png";
    }

    if(type == PersonalityTypes.INFJ.toString()){
      imagePath = "assets/images/personalities/INFJ.png";
    }

    if(type == PersonalityTypes.INTP.toString()){
      imagePath = "assets/images/personalities/INTP.png";
    }

    if(type == PersonalityTypes.ISFJ.toString()){
      imagePath = "assets/images/personalities/ISFJ.png";
    }

    if(type == PersonalityTypes.ISFP.toString()){
      imagePath = "assets/images/personalities/ISFP.png";
    }

    if(type == PersonalityTypes.ISTJ.toString()){
      imagePath = "assets/images/personalities/ISTJ.png";
    }

    if(type == PersonalityTypes.ISTP.toString()){
      imagePath = "assets/images/personalities/ISTP.png";
    }

    if(type == PersonalityTypes.ENFP.toString()){
      imagePath = "assets/images/personalities/ENFP.png";
    }

    if(type == PersonalityTypes.ENTJ.toString()){
      imagePath = "assets/images/personalities/ENTJ.png";
    }

    if(type == PersonalityTypes.ENTP.toString()){
      imagePath = "assets/images/personalities/ENTP.png";
    }

    if(type == PersonalityTypes.ENFJ.toString()){
      imagePath = "assets/images/personalities/ENFJ.png";
    }

    if(type == PersonalityTypes.ESFJ.toString()){
      imagePath = "assets/images/personalities/ESFJ.png";
    }

    if(type == PersonalityTypes.ESFP.toString()){
      imagePath = "assets/images/personalities/ESFP.png";
    }

    if(type == PersonalityTypes.ESTJ.toString()){
      imagePath = "assets/images/personalities/ESTJ.png";
    }

    if(type == PersonalityTypes.ESTP.toString()){
      imagePath = "assets/images/personalities/ESTP.png";
    }

    return imagePath;
  }
}