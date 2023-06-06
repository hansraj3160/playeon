import 'package:shared_preferences/shared_preferences.dart';

class LocalPreference {
  static const userToken = "userToken";

  setUserToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userToken, token);
  }

  Future<dynamic> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userToken);
  }

  removeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(userToken);
    prefs.clear();
  }
}
