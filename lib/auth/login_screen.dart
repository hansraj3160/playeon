import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:playeon/auth/user_model.dart';
import 'package:playeon/services/local_preference_controller.dart';
import 'package:playeon/main_screen.dart';
import 'package:playeon/widgets/style.dart';
import 'package:provider/provider.dart';
import '../models/movies_model.dart';
import '../models/user_model.dart';
import '../provider/filter_movies.dart';
import '../provider/user_provider.dart';
import '../widgets/common.dart';
import 'SignupScreen.dart';
import 'api_controller.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  List<MoviesModel> moviesData = [];
  bool isValid = false;
  bool isLoading = false;
  setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  validate() {
    if (usernameController.text.isNotEmpty) {
      if (passwordController.text.isNotEmpty) {
        isValid = true;
      } else {
        Fluttertoast.showToast(
            msg: "Plase Enter password",
            toastLength: Toast.LENGTH_SHORT); //password
      }
    } else {
      Fluttertoast.showToast(
          msg: "Plase enter Email", toastLength: Toast.LENGTH_SHORT);
    }

    return isValid;
  }

  loginUser() async {
    LocalPreference pref = LocalPreference();
    // ignore: curly_braces_in_flow_control_structures
    if (validate()) {
      setLoading(true);
      UserModel userCred = UserModel(
          username: usernameController.text, password: passwordController.text);
      String logindata = userCred.toJsonString();
      await pref.setCrediantial(logindata);
      var response = await ApiController()
          .loginUser(usernameController.text, passwordController.text);

      // print("Get $response");
      if (response['status']) {
        String token = response['msg'];

        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        await getMovies(token);
        print(decodedToken['userId']);
        User user = User.fromJson(decodedToken['userId']);
        await Provider.of<UserProvider>(context, listen: false).setUSer(user);
        LocalPreference prefs = LocalPreference();
        setLoading(false);
        await prefs.setUserToken(token);
        Navigator.pushReplacement(context,
            SwipeLeftAnimationRoute(milliseconds: 200, widget: MainScreen()));
      } else {
        setLoading(false);
        Fluttertoast.showToast(
            msg: response['msg'], toastLength: Toast.LENGTH_SHORT);
      }
    }
  }

  getMovies(String token) async {
    var response = await ApiController().getMovies(token);

    for (var item in response) {
      moviesData.add(MoviesModel.fromJson(item));
    }
    Provider.of<MoviesGenraProvider>(context, listen: false)
        .setMovies(moviesData);
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          backgroundColor: primaryColorW,
          body: SafeArea(
            child: Stack(
              children: [
                Positioned.fill(
                    child: Image.asset(
                  "assets/images/login_img.png",
                  fit: BoxFit.fill,
                )),
                Positioned.fill(
                    child: Image.asset(
                  "assets/images/login_img2.png",
                  fit: BoxFit.cover,
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icons/logo.png",
                      scale: 1.8,
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                        color: primaryColorB.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(6)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.020,
                          horizontal: size.width * 0.1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              VariableText(
                                text: "LOGIN NOW",
                                fontcolor: textColor1,
                                fontsize: size.height * 0.016,
                                fontFamily: fontSemiBold,
                                weight: FontWeight.w500,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          //!User Name
                          CustomTextField2(
                            cont: usernameController,
                            hintTxt: "Enter Your Email",
                            fill: true,
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          //!password
                          CustomPasswordField2(
                            cont: passwordController,
                            hintTxt: "Enter Your Password",
                            fill: true,
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          MyButton(
                            btnHeight: size.height * 0.055,
                            btnWidth: size.width,
                            btnTxt: "Login",
                            btnColor: primaryColor1.withOpacity(0.8),
                            btnRadius: 6,
                            borderColor: primaryColor1.withOpacity(0.8),
                            txtColor: textColor1,
                            fontSize: 15,
                            onTap: () {
                              loginUser();
                            },
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Divider(
                            thickness: 1.3,
                            color: textColorH,
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              VariableText(
                                text: "Don't have an account? ",
                                fontsize: size.height * 0.016,
                                fontcolor: textColor1,
                                weight: FontWeight.w400,
                                fontFamily: fontRegular,
                                underlined: true,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      SwipeLeftAnimationRoute(
                                          milliseconds: 200,
                                          widget: const SignupScreen()));
                                },
                                child: VariableText(
                                  text: "Create Now",
                                  fontsize: size.height * 0.016,
                                  fontcolor: textColor1,
                                  weight: FontWeight.w600,
                                  fontFamily: fontSemiBold,
                                  underlined: true,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isLoading) ProcessLoadingLight()
      ],
    );
  }
}
