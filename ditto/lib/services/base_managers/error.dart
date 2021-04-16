
import 'package:ditto/services/base_managers/exceptions.dart';

abstract class ErrorManager {

  Stream<SkeletonException> get getErrorText;

  void dispose();

}