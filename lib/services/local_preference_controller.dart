import 'package:shared_preferences/shared_preferences.dart';

class LocalPreference {
  static const userToken = "userToken";
  static const crediantial = "data";
  setUserToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userToken, token);
  }

  Future<dynamic> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userToken);
  }

  setCrediantial(var data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(crediantial, data);
  }

  getCrediantial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(crediantial);
  }

  removeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(userToken);
    prefs.remove(crediantial);
    prefs.clear();
  }
}
