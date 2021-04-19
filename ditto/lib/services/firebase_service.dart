import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ditto/helper/models/errors/exceptions.dart';
import 'package:ditto/service_locator.dart';
import 'package:ditto/services/base_managers/exceptions.dart';
import 'package:ditto/services/error_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../helper/enums.dart';

class FirebaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String> signIn(String email, String password) async {

    UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password).onError((error, stackTrace) {
      SkeletonException exc =  GeneralException(
        error.toString().split("] ").last, ExceptionTypes.REQUEST_ERROR,
      );
      locator<ErrorService>().setError(exc);

      return null;
    });

    User user = result.user;

    print(user.uid);
    return user.uid;
  }

  Future<String> signUp(String email, String password) async {

    UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).onError((error, stackTrace) {
      SkeletonException exc =  GeneralException(
        error.toString().split("] ").last, ExceptionTypes.REQUEST_ERROR,
      );
      locator<ErrorService>().setError(exc);

      return null;
    });

    User user = result.user;
    return user.uid;
  }

  Future<bool> saveStudentDetails({String userId, Map<String, dynamic> map}) async {
    await _firebaseFirestore.collection('student').doc(userId).set(map).onError((error, stackTrace) {
      SkeletonException exc =  GeneralException(
        error.toString(), ExceptionTypes.REQUEST_ERROR,
      );
      locator<ErrorService>().setError(exc);

      return false;
    });

    print("----------------------");
    print("STUDENT RECORD CREATED");
    print("----------------------");

    return true;
  }

  Future<bool> saveTestScore({String userId, Map<String, dynamic> map}) async {
    await _firebaseFirestore.collection('student').doc(userId).update(map).onError((error, stackTrace) {
      SkeletonException exc =  GeneralException(
        error.toString(), ExceptionTypes.REQUEST_ERROR,
      );
      locator<ErrorService>().setError(exc);

      return false;
    });

    print("----------------------");
    print("STUDENT RECORD UPDATED");
    print("----------------------");

    return true;
  }

  Future<bool> setLeaderBoard({String userId, Map<String, dynamic> map}) async {
    await _firebaseFirestore.collection('leaderboard').doc(userId).set(map).onError((error, stackTrace) {
      SkeletonException exc =  GeneralException(
        error.toString(), ExceptionTypes.REQUEST_ERROR,
      );
      locator<ErrorService>().setError(exc);

      return false;
    });

    print("----------------------");
    print("LEADERBOARD RECORD UPDATED");
    print("----------------------");

    return true;
  }

  Future<bool> updateLeaderBoard({String userId, Map<String, dynamic> map}) async {
    await _firebaseFirestore.collection('leaderboard').doc(userId).update(map).onError((error, stackTrace) {
      SkeletonException exc =  GeneralException(
        error.toString(), ExceptionTypes.REQUEST_ERROR,
      );
      locator<ErrorService>().setError(exc);

      return false;
    });

    print("----------------------");
    print("LEADERBOARD RECORD UPDATED");
    print("----------------------");

    return true;
  }

  Future<bool> saveRate({String userId, Map<String, dynamic> map}) async {
    await _firebaseFirestore.collection('student').doc(userId).update(map).onError((error, stackTrace) {
      SkeletonException exc =  GeneralException(
        error.toString(), ExceptionTypes.REQUEST_ERROR,
      );
      locator<ErrorService>().setError(exc);

      return false;
    });

    print("----------------------");
    print("STUDENT RECORD UPDATED");
    print("----------------------");

    return true;
  }

  Future<bool> saveAchievement({String userId, Map<String, dynamic> map}) async {
    await _firebaseFirestore.collection('student').doc(userId).update(map).onError((error, stackTrace) {
      SkeletonException exc =  GeneralException(
        error.toString(), ExceptionTypes.REQUEST_ERROR,
      );
      locator<ErrorService>().setError(exc);

      return false;
    });

    print("----------------------");
    print("STUDENT RECORD UPDATED");
    print("----------------------");

    return true;
  }

  Future<DocumentSnapshot> getStudentDetails({String userId}) async {

    DocumentSnapshot doc;

    doc = await _firebaseFirestore.collection('student').doc(userId).get().onError((error, stackTrace) {
      SkeletonException exc =  GeneralException(
        error.toString(), ExceptionTypes.REQUEST_ERROR,
      );
      locator<ErrorService>().setError(exc);

      return doc;
    });

    return doc;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

}