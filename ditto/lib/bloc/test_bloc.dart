import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ditto/helper/load_events.dart';
import 'package:ditto/service_locator.dart';
import 'package:ditto/services/firebase_service.dart';
import 'package:ditto/services/navigation_service.dart';
import 'package:ditto/services/user_service.dart';
import 'package:event_bus/event_bus.dart';
import 'package:rxdart/rxdart.dart';

class TestBloc {

  final _userService = locator<UserService>();
  final _eventBus = locator<EventBus>();

  List<dynamic> _rating = [];

  BehaviorSubject<int> _questionOneSubject = BehaviorSubject<int>();
  Stream<int> get questionOneStream => _questionOneSubject.stream;
  Sink<int> get questionOneSink => _questionOneSubject.sink;

  BehaviorSubject<int> _questionTwoSubject = BehaviorSubject<int>();
  Stream<int> get questionTwoStream => _questionTwoSubject.stream;
  Sink<int> get questionTwoSink => _questionTwoSubject.sink;

  BehaviorSubject<int> _questionThreeSubject = BehaviorSubject<int>();
  Stream<int> get questionThreeStream => _questionThreeSubject.stream;
  Sink<int> get questionThreeSink => _questionThreeSubject.sink;

  BehaviorSubject<int> _questionFourSubject = BehaviorSubject<int>();
  Stream<int> get questionFourStream => _questionFourSubject.stream;
  Sink<int> get questionFourSink => _questionFourSubject.sink;

  BehaviorSubject<int> _questionFiveSubject = BehaviorSubject<int>();
  Stream<int> get questionFiveStream => _questionFiveSubject.stream;
  Sink<int> get questionFiveSink => _questionFiveSubject.sink;

  BehaviorSubject<int> _ratingSubject = BehaviorSubject<int>();
  Stream<int> get ratingStream => _ratingSubject.stream;
  Sink<int> get ratingSink => _ratingSubject.sink;

  void savePoint() async {

    String _uuid = await _userService.getUserId;

    int points = 0;

    if(_questionOneSubject.stream.value == 2){
      points += 10;
    }
    if(_questionTwoSubject.stream.value == 1){
      points += 10;
    }
    if(_questionThreeSubject.stream.value == 1){
      points += 10;
    }
    if(_questionFourSubject.stream.value == 2){
      points += 10;
    }
    if(_questionFiveSubject.stream.value == 1){
      points += 10;
    }

    _eventBus.fire(LoadEvent.show());
    await locator<FirebaseService>().saveTestScore(userId: _uuid, map: {'points': points});
    await locator<FirebaseService>().updateLeaderBoard(userId: _uuid, map: {'points': points});
    _eventBus.fire(LoadEvent.hide());

    // locator<NavigationService>().pushReplacement('/home');
  }

  void saveFeedback() async {
  }

  void updaterRate() async {

    String _uuid = await _userService.getUserId;

    _rating.add(_ratingSubject.value);

    _eventBus.fire(LoadEvent.show());
    await locator<FirebaseService>().saveRate(userId: _uuid, map: {'test_rate': _rating});
    await locator<FirebaseService>().saveAchievement(userId: _uuid, map: {'isCompleted': true});
    _eventBus.fire(LoadEvent.hide());

    locator<NavigationService>().pop();
    locator<NavigationService>().pushNamed('/home');
  }

  void getStudentDetails() async {

    String _uuid = await _userService.getUserId;

    _eventBus.fire(LoadEvent.show());
    DocumentSnapshot doc = await locator<FirebaseService>().getStudentDetails(userId: _uuid).whenComplete(() {
      _eventBus.fire(LoadEvent.hide());
    });

    _rating = doc.data()['test_rate'].toList();
  }

  void dispose(){
    _questionOneSubject.close();
    _questionTwoSubject.close();
    _questionThreeSubject.close();
    _questionFourSubject.close();
    _questionFiveSubject.close();
    _ratingSubject.close();
  }
}