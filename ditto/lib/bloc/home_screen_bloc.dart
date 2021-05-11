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

class HomeScreenBloc {

  final _contentVariables = ContentVariables.getInstance;

  final _userService = locator<UserService>();
  final _eventBus = locator<EventBus>();

  String _uid;
  List<dynamic> _rating = [];

  PublishSubject<bool> _playPauseVideo = PublishSubject<bool>();
  Stream<bool> get getPlayPauseVideoStream => _playPauseVideo.stream;
  Sink<bool> get getPlayPauseVideoSink => _playPauseVideo.sink;

  BehaviorSubject<bool> _isDoneSubject = BehaviorSubject<bool>();
  Stream<bool> get isDoneStream => _isDoneSubject.stream;
  Sink<bool> get isDoneSink => _isDoneSubject.sink;

  BehaviorSubject<bool> _timeBadgeSubject = BehaviorSubject<bool>();
  Stream<bool> get timeBadgeStream => _timeBadgeSubject.stream;
  Sink<bool> get timeBadgeSink => _timeBadgeSubject.sink;

  BehaviorSubject<bool> _marksBadgeSubject = BehaviorSubject<bool>();
  Stream<bool> get marksBadgeStream => _marksBadgeSubject.stream;
  Sink<bool> get marksBadgeSink => _marksBadgeSubject.sink;

  BehaviorSubject<int> _ratingSubject = BehaviorSubject<int>();
  Stream<int> get ratingStream => _ratingSubject.stream;
  Sink<int> get ratingSink => _ratingSubject.sink;

  BehaviorSubject<GamificationElementType> _elementTypeSubject = BehaviorSubject<GamificationElementType>();
  Stream<GamificationElementType> get elementTypeStream => _elementTypeSubject.stream;
  Sink<GamificationElementType> get elementTypeSink => _elementTypeSubject.sink;

  void navigateToSettings() {
    locator<NavigationService>().pushNamed('/settings');
  }

  void navigateToTest() {
    locator<NavigationService>().pushNamed('/test');
  }

  void getStudentDetails() async {

    String _uuid = await _userService.getUserId;

    _eventBus.fire(LoadEvent.show());
    DocumentSnapshot doc = await locator<FirebaseService>().getStudentDetails(userId: _uuid).whenComplete(() {
      _eventBus.fire(LoadEvent.hide());
    });

    _rating = doc.data()['lec_rate'].toList();
    _uid = _uuid;

    _contentVariables.achievementsBadges = doc.data()['elements']['achievements'];
    _contentVariables.points = doc.data()['elements']['points'];
    _contentVariables.pointsLeaderboard = doc.data()['elements']['pointsL'];
    _contentVariables.timeLeaderboard = doc.data()['elements']['timeL'];
    _contentVariables.progressBar = doc.data()['elements']['progress_bar'];
    _contentVariables.time = doc.data()['elements']['time'];

    isDoneSink.add(doc.data()['isCompleted']);
    marksBadgeSink.add(doc.data()['marks_badge']);
    timeBadgeSink.add(doc.data()['time_badge']);

    getPersonalityType(type: doc.data()['personality']);
  }

  void getPersonalityType({String type}) {

    if(type[0] == "I"){
      elementTypeSink.add(GamificationElementType.I);
    }else{
      elementTypeSink.add(GamificationElementType.E);
    }
  }

  void updaterRate() async {

    String _uuid = await _userService.getUserId;

    _rating.add(_ratingSubject.value);

    _eventBus.fire(LoadEvent.show());
    await locator<FirebaseService>().saveRate(userId: _uuid, map: {'lec_rate': _rating});
    _eventBus.fire(LoadEvent.hide());

    locator<NavigationService>().pop();
  }

  String get getUuid => _uid;

  void dispose(){
    _playPauseVideo.close();
    _elementTypeSubject.close();
    _ratingSubject.close();
    _isDoneSubject.close();
    _timeBadgeSubject.close();
    _marksBadgeSubject.close();
  }
}