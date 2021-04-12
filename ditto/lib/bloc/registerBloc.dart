import 'dart:async';

import 'package:ditto/helper/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc {

  final _firebaseAuth = FirebaseAuth.instance;

  BehaviorSubject<PersonalityTypes> _personalityTypeSubject = BehaviorSubject<PersonalityTypes>();
  Stream<PersonalityTypes> get personalityTypeStream => _personalityTypeSubject.stream;
  StreamController<PersonalityTypes> _personalityTypeStreamController  = StreamController<PersonalityTypes>();
  Sink<PersonalityTypes> get personalityTypeSink => _personalityTypeStreamController.sink;

  RegisterBloc(){
    _personalityTypeStreamController.stream.listen((type) {

      if(type == PersonalityTypes.ENFJ || type == PersonalityTypes.INFJ || type == PersonalityTypes.ENFP || type == PersonalityTypes.INFP){
      // green
      }
      if(type == PersonalityTypes.INTJ || type == PersonalityTypes.ENTJ || type == PersonalityTypes.INTP || type == PersonalityTypes.ENTP){
    // Blue
      }
      if(type == PersonalityTypes.ESFJ || type == PersonalityTypes.ISFP || type == PersonalityTypes.ESFJ || type == PersonalityTypes.ISFJ){
      // Yellow
      }
      if(type == PersonalityTypes.ISTP || type == PersonalityTypes.ESTP || type == PersonalityTypes.ISTJ || type == PersonalityTypes.ESTJ){
      // orange
      }
    });
  }

  void signIn(String email, String password) async {
    UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

    print(user.user.uid);

  }

  void dispose(){
    _personalityTypeSubject.close();
    _personalityTypeStreamController.close();
  }
}