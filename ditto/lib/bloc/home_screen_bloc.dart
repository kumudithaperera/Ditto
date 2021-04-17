import 'package:ditto/service_locator.dart';
import 'package:ditto/services/firebase_service.dart';
import 'package:ditto/services/navigation_service.dart';
import 'package:ditto/services/user_service.dart';
import 'package:rxdart/rxdart.dart';

class HomeScreenBloc {

  final _userService = locator<UserService>();

  PublishSubject<bool> _playPauseVideo = PublishSubject<bool>();
  Stream<bool> get getPlayPauseVideoStream => _playPauseVideo.stream;
  Sink<bool> get getPlayPauseVideoSink => _playPauseVideo.sink;

  void navigateToSettings() {
    locator<NavigationService>().pushNamed('/settings');
  }

  void navigateToTest() {
    locator<NavigationService>().pushNamed('/test');
  }

  Future<String> getPersonalityType() async {
    return await _userService.getPersonalityType;
  }

  void logout(){
    locator<FirebaseService>().signOut();
    locator<NavigationService>().pushReplacement('/');
  }

  void dispose(){
    _playPauseVideo.close();
  }
}