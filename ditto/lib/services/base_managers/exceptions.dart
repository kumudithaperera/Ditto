import '../../helper/enums.dart';

abstract class Exception {
  ExceptionTypes type;
  String message;
  bool isSuccess;
}