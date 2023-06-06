// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:playeon/dashboard/videoplayer.dart';
import 'package:video_player/video_player.dart';

import '../widgets/common.dart';
import '../widgets/style.dart';

class IntroductionPage extends StatelessWidget {
  String? image;
  IntroductionPage({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ]),
            ),
            Expanded(
              child: Image.network(
                image!, 
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
        bottomSheet: Container(
          padding: EdgeInsets.symmetric(
              vertical: size.height * verticalPadding,
              horizontal: size.width * horizontalPadding),
          decoration: BoxDecoration(
              color: primaryColorB,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8))),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Row(
              children: [
                Column(
                  children: [
                    VariableText(
                      text: "Winnie The Pooh",
                      fontcolor: textColor1,
                      fontsize: size.height * 0.02,
                      fontFamily: fontMedium,
                      weight: FontWeight.w500,
                    ),
                    VariableText(
                      text: "1 hr 21 mins",
                      fontcolor: textColor1,
                      fontsize: size.height * 0.02,
                      fontFamily: fontMedium,
                      weight: FontWeight.w500,
                    ),
                    VariableText(
                      text: "Action .Horror .18",
                      fontcolor: textColor1,
                      fontsize: size.height * 0.02,
                      fontFamily: fontMedium,
                      weight: FontWeight.w500,
                    ),
                    // Directionality(
                    //   textDirection: TextDirection.ltr,
                    //   child: TextButton.icon(
                    //       icon: Icon(Icons.play_arrow),
                    //       label: Text("Play"),
                    //       style: OutlinedButton.styleFrom(
                    //         fixedSize: Size(140, 40),
                    //         backgroundColor: primaryColor1,
                    //         primary: textColor1,
                    //         alignment: Alignment.center,
                    //         textStyle: TextStyle(
                    //           fontSize: 20,
                    //           fontWeight: FontWeight.w500,
                    //         ),
                    //         side: BorderSide(
                    //           color: primaryColor1,
                    //         ),
                    //       ),
                    //       onPressed: () {
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => VideoPlayer(),
                    //         ),);
                    //       }),
                    // ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: VariableText(
                    text:
                        "The days of adventures and merriment have come to an end, as Christopher Robin, now a young man, has left Winnie-The-Pooh and Piglet to fend for themselves. As time passes, feeling angry and abandoned, the two become feral. After getting a taste for blood, Winnie-The-Pooh and Piglet set off to find a new source of food. It's not long before their bloody rampage begins",
                    fontcolor: primaryColorW,
                    fontsize: size.height * 0.022,
                    fontFamily: fontSemiBold,
                    weight: FontWeight.w300,
                    letter_spacing: 1.4,
                    line_spacing: 1.2,
                    max_lines: 20,
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
