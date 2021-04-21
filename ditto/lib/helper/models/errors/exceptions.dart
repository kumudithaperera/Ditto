import 'package:ditto/services/base_managers/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../enums.dart';

class GeneralException implements SkeletonException {

  GeneralException(this.message, this.type, {this.isSuccess = false});

  @override
  String message;

  @override
  ExceptionTypes type;

  @override
  String toString() => this.message;

  FirebaseAuthException firebaseAuthException;

  @override
  bool isSuccess;
}