import 'package:shared_preferences/shared_preferences.dart';
import 'Model/LoginModel.dart';
import 'Model/UserModel.dart';

class SaveLogin{
  static final SaveLogin shared = SaveLogin();
  Future<LoginModel?> getUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.get('login') == ""
          ? null
          : loginModelFromJson(prefs.get('login').toString());
    } catch (e) {
      return null;
    }
  }

  setUser({LoginModel? user}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('login', user == null ? "" : loginModelToJson(user));
    } catch (e) {
      return null;
    }
  }
}

class UserProfile {
  static final UserProfile shared = UserProfile();


  Future<UserModel?> getUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.get('user') == "" ? null : userModelFromJson(prefs.get('user').toString());
    } catch (e) {
      return null;
    }
  }

  setUser({UserModel? user}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', user == null ? "" : userModelToJson(user));
    } catch (e) {
      return null;
    }
  }
}




