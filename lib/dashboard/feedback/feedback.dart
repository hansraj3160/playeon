import 'package:flutter/material.dart';
import 'package:playeon/widgets/common.dart';
import 'package:playeon/widgets/style.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColorB,
      appBar: AppBar(
        backgroundColor: primaryColor1,
        title: VariableText(
          text: "Feedback",
          fontcolor: primaryColorW,
          fontsize: size.height * 0.018,
          weight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * horizontalPadding,
            vertical: size.height * verticalPadding),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.01,
            ),
            VariableText(
              text: "Feedback",
              fontcolor: primaryColorW,
              fontsize: size.height * 0.018,
              weight: FontWeight.w600,
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            CustomTextField(
              hintTxt: "Left your feedback",
              maxLine: 7,
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyButton(
                  btnHeight: size.height * 0.055,
                  btnWidth: size.width * 0.70,
                  btnTxt: "Submit",
                  btnColor: Colors.white,
                  btnRadius: 25,
                  borderColor: textColor1,
                  txtColor: textColor5,
                  fontSize: 15,
                  onTap: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
