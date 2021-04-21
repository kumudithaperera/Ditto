import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ditto/helper/enums.dart';
import 'package:ditto/helper/load_events.dart';
import 'package:ditto/service_locator.dart';
import 'package:ditto/services/firebase_service.dart';
import 'package:ditto/services/navigation_service.dart';
import 'package:ditto/services/user_service.dart';
import 'package:event_bus/event_bus.dart';
import 'package:rxdart/rxdart.dart';

class SettingsScreenBloc {

  final _userService = locator<UserService>();
  final _eventBus = locator<EventBus>();

  BehaviorSubject<UserDetailsModel> _userDetailsSubject = BehaviorSubject<UserDetailsModel>();
  Stream<UserDetailsModel> get userDetailsStream => _userDetailsSubject.stream;
  Sink<UserDetailsModel> get userDetailsSink => _userDetailsSubject.sink;

  void getStudentDetails() async {

    String _uuid = await _userService.getUserId;

    _eventBus.fire(LoadEvent.show());
    DocumentSnapshot doc = await locator<FirebaseService>().getStudentDetails(userId: _uuid).whenComplete(() {
      _eventBus.fire(LoadEvent.hide());
    });

    userDetailsSink.add(UserDetailsModel(doc.data()));
  }

  void updateEmail({String newEmail, String personality}) async {

    String uid = await _userService.getUserId;
    String email = await _userService.getUserEmail;
    String password = await _userService.getUserPassword;

    print(email);
    print(newEmail);

    try{

      _eventBus.fire(LoadEvent.show());

      if(newEmail != null){
        await locator<FirebaseService>().changeEmail(newEmail: newEmail, oldEmail: email, password: password);
      }

      await locator<FirebaseService>().updateStudentEmail(userId: uid, map: {
        'email': newEmail != null ? newEmail : email,
        'personality': personality,
      });
      _eventBus.fire(LoadEvent.hide());

      _userService.saveUserEmail(newEmail != null ? newEmail : email);
      _userService.saveUserPassword(password);

      locator<NavigationService>().showError(ExceptionTypes.SUCCESS, "Data Changed Successfully!!", true);

    }catch(error){
      print(error.toString());
    }
  }

  void dispose() {
    _userDetailsSubject.close();
  }
}

class UserDetailsModel{
  String name;
  String email;
  String personalityType;
  bool isCompleted;

  UserDetailsModel(Map<String, dynamic> parsedJson){
    name = parsedJson['name'] ?? "";
    email = parsedJson['email'] ?? "";
    personalityType = parsedJson['personality'] ?? "";
    isCompleted = parsedJson['isCompleted'] ?? false;
  }
}