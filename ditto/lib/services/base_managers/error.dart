
import 'package:ditto/services/base_managers/exceptions.dart';

abstract class ErrorManager {

  Stream<Exception> get getErrorText;

  void dispose();

}