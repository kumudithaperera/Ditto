import 'package:ditto/services/base_managers/exceptions.dart';

class Error {
  final Exception exception;
  final StackTrace stackTrace;

  Error(this.exception, this.stackTrace);
}