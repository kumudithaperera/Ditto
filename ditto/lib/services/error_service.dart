import 'dart:async';

import 'package:ditto/services/base_managers/error.dart';
import 'package:ditto/services/base_managers/exceptions.dart';

class ErrorService extends ErrorManager {

  final StreamController<Exception> _streamController = StreamController<Exception>();

  @override
  void dispose() => _streamController.close();

  @override
  Stream<Exception> get getErrorText => _streamController.stream;

  void setError(Exception error) => _streamController.add(error);

}