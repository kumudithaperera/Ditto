import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ditto/helper/app_data.dart';
import 'package:ditto/helper/enums.dart';
import 'package:ditto/helper/load_events.dart';
import 'package:ditto/service_locator.dart';
import 'package:ditto/services/firebase_service.dart';
import 'package:ditto/services/navigation_service.dart';
import 'package:ditto/services/user_service.dart';
import 'package:event_bus/event_bus.dart';
import 'package:rxdart/rxdart.dart';

class SettingsScreenBloc {

  final _appData = AppData.getInstance;

  final _userService = locator<UserService>();
  final _eventBus = locator<EventBus>();

  BehaviorSubject<UserDetailsModel> _userDetailsSubject = BehaviorSubject<UserDetailsModel>();
  Stream<UserDetailsModel> get userDetailsStream => _userDetailsSubject.stream;
  Sink<UserDetailsModel> get userDetailsSink => _userDetailsSubject.sink;

  BehaviorSubject<bool> _pointsLeaderboardSubject = BehaviorSubject<bool>();
  Stream<bool> get pointsLeaderboardStream => _pointsLeaderboardSubject.stream;
  Sink<bool> get pointsLeaderboardSink => _pointsLeaderboardSubject.sink;

  BehaviorSubject<bool> _timeLeaderboardSubject = BehaviorSubject<bool>();
  Stream<bool> get timeLeaderboardStream => _timeLeaderboardSubject.stream;
  Sink<bool> get timeLeaderboardSink => _timeLeaderboardSubject.sink;

  BehaviorSubject<bool> _achievementAndBadgesSubject = BehaviorSubject<bool>();
  Stream<bool> get achievementAndBadgesStream => _achievementAndBadgesSubject.stream;
  Sink<bool> get achievementAndBadgesSink => _achievementAndBadgesSubject.sink;

  BehaviorSubject<bool> _progressBarSubject = BehaviorSubject<bool>();
  Stream<bool> get progressBarStream => _progressBarSubject.stream;
  Sink<bool> get progressBarSink => _progressBarSubject.sink;

  BehaviorSubject<bool> _pointsSubject = BehaviorSubject<bool>();
  Stream<bool> get pointsStream => _pointsSubject.stream;
  Sink<bool> get pointsSink => _pointsSubject.sink;

  BehaviorSubject<bool> _timeSubject = BehaviorSubject<bool>();
  Stream<bool> get timeStream => _timeSubject.stream;
  Sink<bool> get timeSink => _timeSubject.sink;

  void getStudentDetails() async {

    String _uuid = await _userService.getUserId;

    _eventBus.fire(LoadEvent.show());
    DocumentSnapshot doc = await locator<FirebaseService>().getStudentDetails(userId: _uuid).whenComplete(() {
      _eventBus.fire(LoadEvent.hide());
    });

    achievementAndBadgesSink.add(doc.data()['elements']['achievements']);
    pointsSink.add(doc.data()['elements']['points']);
    pointsLeaderboardSink.add(doc.data()['elements']['pointsL']);
    timeLeaderboardSink.add(doc.data()['elements']['timeL']);
    progressBarSink.add(doc.data()['elements']['progress_bar']);
    timeSink.add(doc.data()['elements']['time']);

    _appData.achievementsBadges = doc.data()['elements']['achievements'];
    _appData.points = doc.data()['elements']['points'];
    _appData.pointsLeaderboard = doc.data()['elements']['pointsL'];
    _appData.timeLeaderboard = doc.data()['elements']['timeL'];
    _appData.progressBar = doc.data()['elements']['progress_bar'];
    _appData.time = doc.data()['elements']['time'];

    userDetailsSink.add(UserDetailsModel(doc.data()));
  }

  void updateEmail({String newEmail, String personality, bool isOld}) async {

    String uid = await _userService.getUserId;
    String email = await _userService.getUserEmail;
    String password = await _userService.getUserPassword;

    try{

      _eventBus.fire(LoadEvent.show());

      if(newEmail != null){
        await locator<FirebaseService>().changeEmail(newEmail: newEmail, oldEmail: email, password: password);
      }

      await locator<FirebaseService>().updateStudentEmail(userId: uid, map: {
        'email': newEmail != null ? newEmail : email,
        'personality': personality,
        'elements': !isOld ? _gameElements(personality[0]) : {
          'achievements': _achievementAndBadgesSubject.value,
          'points': _pointsSubject.value,
          'pointsL': _pointsLeaderboardSubject.value,
          'progress_bar': _progressBarSubject.value,
          'timeL': _timeLeaderboardSubject.value,
          'time': _timeSubject.value,
        },
      }).whenComplete(() => getStudentDetails());
      _eventBus.fire(LoadEvent.hide());

      _userService.saveUserEmail(newEmail != null ? newEmail : email);
      _userService.saveUserPassword(password);

      locator<NavigationService>().showError(ExceptionTypes.SUCCESS, "Data Changed Successfully!!", true);

    }catch(error){
      print(error.toString());
    }
  }

  Map<String, bool> _gameElements(String personality){

    print(personality);

    if(personality == "I"){
      return {
        'achievements': true,
        'points': false,
        'pointsL': false,
        'progress_bar': true,
        'timeL': true,
        'time': true,
      };
    }
    if(personality == "E"){
      return {
        'achievements': false,
        'points': true,
        'pointsL': true,
        'progress_bar': false,
        'timeL': true,
        'time': true,
      };
    }

    return {
      'achievements': false,
      'points': false,
      'pointsL': false,
      'progress_bar': false,
      'timeL': false,
      'time': false,
    };
  }

  void dispose() {
    _userDetailsSubject.close();
    _pointsLeaderboardSubject.close();
    _timeLeaderboardSubject.close();
    _achievementAndBadgesSubject.close();
    _progressBarSubject.close();
    _pointsSubject.close();
    _timeSubject.close();
  }
}

class UserDetailsModel{
  String name;
  String email;
  String personalityType;
  bool isCompleted;
  GameElements gameElements;

  UserDetailsModel(Map<String, dynamic> parsedJson){
    name = parsedJson['name'] ?? "";
    email = parsedJson['email'] ?? "";
    personalityType = parsedJson['personality'] ?? "";
    isCompleted = parsedJson['isCompleted'] ?? false;

    if (parsedJson['elements'] != null) {
      gameElements = GameElements(parsedJson['elements']);
    }
  }
}

class GameElements {
  bool achievementsAndBadges;
  bool points;
  bool pointsLeaderboard;
  bool timeLeaderboard;
  bool progressBar;
  bool time;

  GameElements(Map<String, dynamic> parseJSON){
    achievementsAndBadges = parseJSON['achievements'] ?? false;
    points = parseJSON['points'] ?? false;
    pointsLeaderboard = parseJSON['pointsL'] ?? false;
    timeLeaderboard = parseJSON['timeL'] ?? false;
    progressBar = parseJSON['progress_bar'] ?? false;
    time = parseJSON['time'] ?? false;
  }
}