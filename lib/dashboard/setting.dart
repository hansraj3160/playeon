// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:playeon/auth/login_screen.dart';
import 'package:playeon/dashboard/about.dart';

import '../widgets/common.dart';
import '../widgets/style.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 35.0, left: 15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Icon(
                  Icons.arrow_back_ios,
                  color: textColor1,
                  size: 17,
                ),
                VariableText(
                  text: "Back",
                  fontcolor: textColor1,
                  fontsize: size.height * 0.022,
                  fontFamily: fontSemiBold,
                  textAlign: TextAlign.start,
                  weight: FontWeight.w500,
                ),
              ]),
            ),
            SizedBox(
              height: 30,
            ),
            VariableText(
              text: "Setting",
              fontcolor: textColor1,
              fontsize: size.height * 0.022,
              fontFamily: fontSemiBold,
              textAlign: TextAlign.start,
              weight: FontWeight.w500,
            ),
            SizedBox(
              height: 10,
            ),
            ExpansionTile(
              title: VariableText(
                text: "Clear Cache",
                fontcolor: textColor1,
                fontsize: size.height * 0.022,
                fontFamily: fontSemiBold,
                textAlign: TextAlign.start,
                weight: FontWeight.w500,
              ),
              trailing: VariableText(
                text: "250MB",
                fontcolor: textColor1,
                fontsize: size.height * 0.022,
                fontFamily: fontSemiBold,
                textAlign: TextAlign.start,
                weight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            ExpansionTile(
              title: VariableText(
                text: "Share the app",
                fontcolor: textColor1,
                fontsize: size.height * 0.022,
                fontFamily: fontSemiBold,
                textAlign: TextAlign.start,
                weight: FontWeight.w500,
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right_sharp,
                color: textColor1,
                size: 30,
              ),
            ),
            ExpansionTile(
              title: VariableText(
                text: "Forget Pasword",
                fontcolor: textColor1,
                fontsize: size.height * 0.022,
                fontFamily: fontSemiBold,
                textAlign: TextAlign.start,
                weight: FontWeight.w500,
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right_sharp,
                color: textColor1,
                size: 30,
              ),
            ),
            ExpansionTile(
              title: VariableText(
                text: "About",
                fontcolor: textColor1,
                fontsize: size.height * 0.022,
                fontFamily: fontSemiBold,
                textAlign: TextAlign.start,
                weight: FontWeight.w500,
              ),
              trailing: IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_right_sharp,
                    color: textColor1,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => About()),
                    );
                  }),
            ),
            SizedBox(
              height: 100,
            ),
            Center(
              child: MyButton(
                btnHeight: size.height * 0.055,
                btnWidth: size.width * 0.70,
                btnTxt: "Sign Out",
                btnColor: Colors.white,
                btnRadius: 25,
                borderColor: textColor1,
                txtColor: textColor5,
                fontSize: 20,
                onTap: () {
                  Navigator.push(
                      context,
                      SwipeLeftAnimationRoute(
                          milliseconds: 200, widget: LoginScreen()));
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}


