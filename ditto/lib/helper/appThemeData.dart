import 'package:ditto/helper/enums.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

final appThemeData = {
  AppTheme.Pink : ThemeData(
      primaryColor:  PrimaryColorBasic,

  ),
  AppTheme.Blue : ThemeData(
    primaryColor:  PrimaryColorBlue,
      backgroundColor: SecondaryColorBlue,
  ),
  AppTheme.Green : ThemeData(
    primaryColor:  PrimaryColorGreen,
    backgroundColor: SecondaryColorGreen,
  ),
  AppTheme.Gold : ThemeData(
    primaryColor:  PrimaryColorGold,
    backgroundColor: SecondaryColorGold,
  ),
  AppTheme.Orange : ThemeData(
    primaryColor:  PrimaryColorOrange,
    backgroundColor: SecondaryColorOrange,
  ),

}