import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ditto/helper/enums.dart';
import 'package:ditto/helper/load_events.dart';
import 'package:ditto/service_locator.dart';
import 'package:ditto/services/firebase_service.dart';
import 'package:ditto/services/navigation_service.dart';
import 'package:ditto/services/user_service.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

class SignInSignUpBloc {

  final _userService = locator<UserService>();
  final _eventBus = locator<EventBus>();

  String _uid;
  String _personalityType = "";

  void navigateToHomeScreen(){
    locator<NavigationService>().pushReplacement('/home');
  }

  Future<bool> loginUser({String email, String password}) async{

    try{

      _eventBus.fire(LoadEvent.show());
      String uid = await locator<FirebaseService>().signIn(email, password);
      _eventBus.fire(LoadEvent.hide());

      _userService.saveUserId(uid);
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

      _userService.saveUserId(uid);
      print("User Id: $uid");

    }catch(error){
      print(error.toString());

    }
  }

  Future<bool> getStudentDetails() async {

    String _uuid = await _userService.getUserId;

    _eventBus.fire(LoadEvent.show());
    DocumentSnapshot doc = await locator<FirebaseService>().getStudentDetails(userId: _uuid).whenComplete(() {
      _eventBus.fire(LoadEvent.hide());
    });

    print(doc.data()['personality']);
    _personalityType = 'PersonalityTypes.${doc.data()['personality']}';
    print(_personalityType);

    // _themeNotifier.themeNotifier('PersonalityTypes.${doc.data()['personality']}');
    _userService.savePersonalityType('PersonalityTypes.${doc.data()['personality']}');

    return true;
  }

  String get getUid => _uid;

  String get getPersonalityType => _personalityType;

  void logout(){
    _userService.clear().whenComplete(() {
      locator<FirebaseService>().signOut();
    });
    locator<NavigationService>().pushReplacement('/');
  }
}