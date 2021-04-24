import 'package:ditto/helper/enums.dart';

class AppData {

  //Singleton
  AppData._privateConstructor();
  static final AppData _instance = AppData._privateConstructor();
  static AppData get getInstance => _instance;

  bool achievementsBadges;
  bool pointsLeaderboard;
  bool timeLeaderboard;
  bool time;
  bool points;
  bool progressBar;
}