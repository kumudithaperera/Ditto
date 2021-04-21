import '../../helper/enums.dart';

abstract class SkeletonException {
  ExceptionTypes type;
  String message;
  bool isSuccess;
}