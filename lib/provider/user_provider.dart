import 'package:flutter/material.dart';

import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  User? user;

  setUSer(User? userdata) {
    user = userdata;
    notifyListeners();
  }
}
