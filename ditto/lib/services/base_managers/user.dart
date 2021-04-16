
abstract class UserManager {

  Future<bool> get isLoggedIn;

  Future<String> get getUserId;

  Future<String> get getPersonalityType;

  void saveUserId(String uid);

  void savePersonalityType(String personalityType);

  void clear();
}