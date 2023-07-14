import 'package:flutter/material.dart';
import 'package:playeon/widgets/common.dart';
import 'package:playeon/widgets/style.dart';

import '../../auth/api_controller.dart';
import '../../auth/user_model.dart';
import '../../services/local_preference_controller.dart';

class RequestMovieScreen extends StatefulWidget {
  RequestMovieScreen({super.key});

  @override
  State<RequestMovieScreen> createState() => _RequestMovieScreenState();
}

class _RequestMovieScreenState extends State<RequestMovieScreen> {
  TextEditingController _requestMovies = TextEditingController();

  bool isLoading = false;

  setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  postRequest() async {
    LocalPreference pref = LocalPreference();
    // ignore: curly_braces_in_flow_control_structures
    if (_requestMovies.text.isNotEmpty) {
      setLoading(true);
      String token = await pref.getUserToken();
      var response =
          await ApiController().requestMovies(token, _requestMovies.text);
      setLoading(false);
      print(response);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: primaryColorB,
            appBar: AppBar(
              backgroundColor: primaryColorB,
              title: VariableText(
                text: "Movie Request",
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  VariableText(
                    text: "Movie Request",
                    fontcolor: primaryColorW,
                    fontsize: size.height * 0.02,
                    weight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  CustomTextField(
                    cont: _requestMovies,
                    hintTxt: "Write your Movie Request",
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
                          postRequest();
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          if (isLoading) ProcessLoadingLight()
        ],
      ),
    );
  }
}
