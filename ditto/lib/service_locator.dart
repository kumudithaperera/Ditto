import 'package:ditto/services/error_service.dart';
import 'package:ditto/services/firebase_service.dart';
import 'package:ditto/services/navigation_service.dart';
import 'package:ditto/services/user_service.dart';
import 'package:event_bus/event_bus.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => ErrorService());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => FirebaseService());
  locator.registerLazySingleton(() => EventBus());
}