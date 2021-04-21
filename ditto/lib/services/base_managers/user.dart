
abstract class UserManager {

  Future<bool> get isLoggedIn;

  Future<String> get getUserId;

  Future<String> get getUserEmail;

  Future<String> get getUserPassword;

  Future<String> get getPersonalityType;

  void saveUserId(String uid);

  void saveUserEmail(String email);

  void saveUserPassword(String password);

  void savePersonalityType(String personalityType);

  void clear();
}