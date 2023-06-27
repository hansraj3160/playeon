import 'package:flutter/material.dart';
import 'package:playeon/widgets/common.dart';
import 'package:playeon/widgets/style.dart';

import '../../auth/api_controller.dart';
import '../../auth/user_model.dart';
import '../../services/local_preference_controller.dart';

class FeedbackScreen extends StatefulWidget {
  FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  TextEditingController _feedbackController = TextEditingController();

  bool isLoading = false;

  setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  postFeedback() async {
    LocalPreference pref = LocalPreference();
    // ignore: curly_braces_in_flow_control_structures
    if (_feedbackController.text.isNotEmpty) {
      setLoading(true);
      String token = await pref.getUserToken();
      var response =
          await ApiController().feedback(token, _feedbackController.text);
      print(response);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
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
                fontsize: size.height * 0.02,
                weight: FontWeight.w600,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              CustomTextField(
                cont: _feedbackController,
                hintTxt: "Write your feedback",
                maxLine: 7,
              ),
              SizedBox(
                height: size.height * 0.02,
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
                    onTap: () {
                      postFeedback();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
