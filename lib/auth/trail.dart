import 'package:flutter/material.dart';
import 'package:playeon/dashboard/home_screen.dart';
import 'package:playeon/main_screen.dart';

import '../widgets/common.dart';
import '../widgets/style.dart';

class TrailScreen extends StatefulWidget {
  const TrailScreen({super.key});

  @override
  State<TrailScreen> createState() => _TrailScreenState();
}

class _TrailScreenState extends State<TrailScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
            child: Container(
              width: size.width,
              height: size.height * 0.4,
              color: backgroundColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 70),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    VariableText(
                      text: "Step 4 of 4",
                      fontcolor: textColor1,
                      fontsize: size.height * 0.016,
                      fontFamily: fontMedium,
                      weight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    MyButton(
                      btnHeight: size.height * 0.075,
                      btnWidth: size.width,
                      btnTxt: "Start Your 3 Days Trial",
                      btnColor: textColor1,
                      btnRadius: 12,
                      borderColor: textColor1,
                      txtColor: textColor2,
                      fontSize: 20,
                      onTap: () {
                        Navigator.push(
                            context,
                            SwipeLeftAnimationRoute(
                                milliseconds: 200, widget: MainScreen()));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
