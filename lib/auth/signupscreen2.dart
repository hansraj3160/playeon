// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:playeon/auth/paymentScreen.dart';
import 'package:playeon/auth/user_model.dart';
import 'package:playeon/widgets/common.dart';
import 'package:playeon/widgets/style.dart';

class SignupScreen2 extends StatelessWidget {
  UserModel? userData;
  SignupScreen2({super.key, this.userData});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,   
      body: Stack(
        children: [
          Image.asset(
            "assets/images/sign_up2.png",
            height: 400,
            width: double.infinity,
            fit: BoxFit.cover,
          ),                   
          Column(children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {            
                        Navigator.of(context).pop();
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
                              color: primaryColorW,
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
                    // code for live video icon
                  ]),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, top: 320),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  width: size.width * 0.90,
                  height: size.height * 0.40,
                  padding: EdgeInsets.all(10),
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      VariableText(
                        text:
                            "Unlimited collection of movies, series & tv programs  ",
                        fontcolor: textColor1,
                        fontsize: size.height * 0.032,
                        fontFamily: fontMedium,
                        weight: FontWeight.w700,
                        max_lines: 3,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 5),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          VariableText(
                            text:
                                "Watch anytime any where. Cancel your subscription at any time with refund",
                            fontcolor: textColor1,
                            fontsize: size.height * 0.024,
                            fontFamily: fontMedium,
                            weight: FontWeight.w500,
                            textAlign: TextAlign.center,
                            max_lines: 3,
                          ),
                        ],
                      ),
                      SizedBox(height: 35),
                      MyButton(
                        btnHeight: size.height * 0.055,
                        btnWidth: size.width,
                        btnTxt: "Start Watching",
                        btnColor: textColor1,
                        btnRadius: 5,
                        borderColor: textColor1,
                        txtColor: textColor2,
                        fontSize: 20,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => paymentScreen( userData : userData)
                                )
                                ,
                               
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ]),
        ],
      ),
    );
  }
}
