import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ditto/helper/load_events.dart';
import 'package:ditto/service_locator.dart';
import 'package:ditto/services/firebase_service.dart';
import 'package:ditto/services/navigation_service.dart';
import 'package:ditto/services/user_service.dart';
import 'package:event_bus/event_bus.dart';

class SignInSignUpBloc {

  final _userService = locator<UserService>();
  final _eventBus = locator<EventBus>();

  String _personalityType = "";
  String _uuid;

  void navigateToHomeScreen(){
    locator<NavigationService>().pushReplacement('/home');
  }

  Future<bool> loginUser({String email, String password}) async{

    String uid;

    try{

      _eventBus.fire(LoadEvent.show());
      uid = await locator<FirebaseService>().signIn(email, password);
      _eventBus.fire(LoadEvent.hide());
      _userService.saveUserId(uid);
      _userService.saveUserEmail(email);
      _userService.saveUserPassword(password);
      print("User Id: $uid");

      return true;
    }catch(error){
      print(error.toString());
      return false;
    }
  }

  void registerUser({String name, String email, String password, String personality}) async {
    String uid;
    Map<String, dynamic> _studentDetails = {
      'name': name,
      'email': email,
      'personality': personality,
      'points': 0,
      'lec_rate': [],
      'test_rate': [],
      'isCompleted': false,
    };

    Map<String, dynamic> _leaderboard = {
      'name': name,
      'points': 0,
    };

    try{

      _eventBus.fire(LoadEvent.show());
      uid = await locator<FirebaseService>().signUp(email, password);
      await locator<FirebaseService>().saveStudentDetails(userId: uid, map: _studentDetails);
      await locator<FirebaseService>().setLeaderBoard(userId: uid, map: _leaderboard);
      _eventBus.fire(LoadEvent.hide());

      if(uid != null){
        locator<NavigationService>().pushReplacement('/home');
      }

      _userService.saveUserEmail(email);
      _userService.saveUserPassword(password);
      _userService.saveUserId(uid);
      print("User Id: $uid");

    }catch(error){
      print(error.toString());

    }
  }

  Future<bool> getStudentDetails() async {

    _uuid = await _userService.getUserId;

    _eventBus.fire(LoadEvent.show());
    DocumentSnapshot doc = await locator<FirebaseService>().getStudentDetails(userId: _uuid);
    _eventBus.fire(LoadEvent.hide());

    if(doc.data() != null){
      _personalityType = 'PersonalityTypes.${doc.data()['personality']}';
      _userService.savePersonalityType('PersonalityTypes.${doc.data()['personality']}');

      locator<NavigationService>().pushReplacement('/home');
    }

    return true;
  }

  String get getPersonalityType => _personalityType;

  void logout(){
    _userService.clear().whenComplete(() {
      locator<FirebaseService>().signOut();
    });
    locator<NavigationService>().pushReplacement('/');
  }
}