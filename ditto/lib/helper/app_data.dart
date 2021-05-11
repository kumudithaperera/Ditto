class ContentVariables {

  //Singleton
  //Instantiated once, and can provide easy access to the single instance
  ContentVariables._privateConstructor();
  static final ContentVariables _instance = ContentVariables._privateConstructor();
  static ContentVariables get getInstance => _instance;

  bool achievementsBadges;
  bool pointsLeaderboard;
  bool timeLeaderboard;
  bool time;
  bool points;
  bool progressBar;
}