import 'package:ditto/service_locator.dart';
import 'package:ditto/services/firebase_service.dart';
import 'package:ditto/services/navigation_service.dart';
import 'package:ditto/services/user_service.dart';

class HomeScreenBloc {

  final _userService = locator<UserService>();

  Future<String> getPersonalityType() async {
    return await _userService.getPersonalityType;
  }

  void logout(){
    locator<FirebaseService>().signOut();
    locator<NavigationService>().pushReplacement('/');
  }
}