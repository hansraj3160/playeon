// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:playeon/auth/login_screen.dart';
import 'package:playeon/auth/user_model.dart';

import 'package:playeon/widgets/common.dart';
import 'package:playeon/widgets/style.dart';
import 'package:provider/provider.dart';

import '../auth/api_controller.dart';
import '../main_screen.dart';
import '../models/user_model.dart';
import '../provider/user_provider.dart';
import '../services/local_preference_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    proced();
    super.initState();
  }

  proced() async {
    UserModel userCredaintial = UserModel();
    LocalPreference pref = LocalPreference();
    String? loginData = await pref.getCrediantial();
    print(loginData);
    if (loginData != null) {
      Map<String, dynamic> login = json.decode(loginData);
      UserModel user = UserModel.fromJson(login);
      var response =
          await ApiController().loginUser(user.username!, user.password!);

      if (response['status']) {
        String token = response['msg'];

        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

        User user = User.fromJson(decodedToken['userId']);
        await Provider.of<UserProvider>(context, listen: false).setUSer(user);
        LocalPreference prefs = LocalPreference();
        await prefs.setUserToken(token);
        Navigator.pushReplacement(context,
            SwipeLeftAnimationRoute(milliseconds: 200, widget: MainScreen()));
      } else {
        Fluttertoast.showToast(
            msg: response['msg'], toastLength: Toast.LENGTH_SHORT);
      }
    } else {
      Future.delayed(Duration(seconds: 3)).then((value) =>
          Navigator.pushReplacement(
              context,
              SwipeLeftAnimationRoute(
                  milliseconds: 300, widget: LoginScreen())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/ic_splogo.png", scale: 2.7),
                  ],
                ),
                SizedBox(
                  height: 70,
                  child: Text(
                    "Copyright © 2017",
                    style: TextStyle(
                      fontFamily: 'Arial',
                      fontSize: 18,
                      color: Colors.transparent,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
