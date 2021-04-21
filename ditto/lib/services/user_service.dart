import 'package:ditto/services/base_managers/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// User service is to get user defined values in a global context as a temp cache
class UserService extends UserManager{

  @override
  Future<String> get getUserId async {
    final instance = await SharedPreferences.getInstance();
    return instance.getString('userId');
  }

  @override
  Future<String> get getUserPassword async {
    final instance = await SharedPreferences.getInstance();
    return instance.getString('password');
  }

  @override
  Future<String> get getPersonalityType async {
    final instance = await SharedPreferences.getInstance();
    return instance.getString('personalityType');
  }

  @override
  Future<bool> get isLoggedIn async {
    final instance = await SharedPreferences.getInstance();
    return instance.containsKey('userId');
  }

  @override
  void saveUserId(String userId) async {
    final instance = await SharedPreferences.getInstance();
    instance.setString('userId', userId);
  }

  @override
  void saveUserPassword(String password) async {
    final instance = await SharedPreferences.getInstance();
    instance.setString('password', password);
  }

  @override
  void savePersonalityType(String personalityType) async {
    final instance = await SharedPreferences.getInstance();
    instance.setString('personalityType', personalityType);
  }

  @override
  Future<bool> clear() async {
    final instance = await SharedPreferences.getInstance();
    return instance.clear();
  }

  @override
  Future<String> get getUserEmail async {
    final instance = await SharedPreferences.getInstance();
    return instance.getString('email');
  }

  @override
  void saveUserEmail(String email) async {
    final instance = await SharedPreferences.getInstance();
    instance.setString('email', email);
  }
}