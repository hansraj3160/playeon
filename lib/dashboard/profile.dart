import 'package:flutter/material.dart';
import 'package:playeon/dashboard/feedback/feedback.dart';
import 'package:playeon/dashboard/privacy_policy/privacy_policy.dart';
import 'package:playeon/dashboard/requestMovie/requestMovie.dart';
import 'package:playeon/dashboard/setting.dart';

import 'package:playeon/widgets/style.dart';
import 'package:provider/provider.dart';

import '../auth/login_screen.dart';
import '../models/user_model.dart';
import '../provider/user_provider.dart';
import '../services/local_preference_controller.dart';
import '../widgets/common.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<String> images = [
    "assets/images/act2.png",
    "assets/images/adv3.png",
    "assets/images/animat3.png",
    "assets/images/cont1.png",
    "assets/images/for3.png",
    "assets/images/rom3.png",
    "assets/images/trend1.png",
    "assets/images/trend4.png",
    "assets/images/cont2.png",
    "assets/images/act2.png",
    "assets/images/adv3.png",
    "assets/images/animat3.png",
    "assets/images/cont1.png",
    "assets/images/for3.png",
    "assets/images/rom3.png",
    "assets/images/trend1.png",
    "assets/images/trend4.png",
    "assets/images/cont2.png",
    "assets/images/act2.png",
    "assets/images/adv3.png",
    "assets/images/animat3.png",
    "assets/images/cont1.png",
    "assets/images/for3.png",
    "assets/images/rom3.png",
    "assets/images/trend1.png",
    "assets/images/trend4.png",
    "assets/images/cont2.png",
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    User? userdata = Provider.of<UserProvider>(context).user;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: size.height * verticalPadding,
                horizontal: size.width * horizontalPadding),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(children: [
                    Expanded(
                      child: VariableText(
                        text: "Profile",
                        fontcolor: textColor1,
                        fontsize: size.height * 0.02,
                        fontFamily: fontMedium,
                        weight: FontWeight.w500,
                      ),
                    ),
                    // IconButton(
                    //     icon: Icon(Icons.settings, color: textColor1),
                    //     onPressed: () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => const Setting()),
                    //       );
                    //     }),
                  ]),
                  SizedBox(
                    child: Container(
                      color: backgroundColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  userdata!.profilePicture!,
                                  scale: 3,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: VariableText(
                                  text: "Name",
                                  fontsize: size.height * 0.02,
                                  fontFamily: fontMedium,
                                  fontcolor: textColor1,
                                  weight: FontWeight.w500,
                                  max_lines: 2,
                                ),
                              ),
                              VariableText(
                                text: userdata.name,
                                fontsize: size.height * 0.02,
                                fontFamily: fontMedium,
                                fontcolor: textColor1.withOpacity(0.8),
                                weight: FontWeight.w500,
                                max_lines: 2,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: VariableText(
                                  text: "Email",
                                  fontsize: size.height * 0.02,
                                  fontFamily: fontMedium,
                                  fontcolor: textColor1,
                                  weight: FontWeight.w500,
                                  max_lines: 2,
                                ),
                              ),
                              VariableText(
                                text: userdata.email,
                                fontsize: size.height * 0.02,
                                fontFamily: fontMedium,
                                fontcolor: textColor1.withOpacity(0.8),
                                weight: FontWeight.w500,
                                max_lines: 2,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: VariableText(
                                  text: "Password",
                                  fontsize: size.height * 0.02,
                                  fontFamily: fontMedium,
                                  fontcolor: textColor1,
                                  weight: FontWeight.w500,
                                  max_lines: 2,
                                ),
                              ),
                              VariableText(
                                text: "************",
                                fontsize: size.height * 0.02,
                                fontFamily: fontMedium,
                                fontcolor: textColor1.withOpacity(0.8),
                                weight: FontWeight.w500,
                                max_lines: 2,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: VariableText(
                                  text: "Phone Number",
                                  fontsize: size.height * 0.02,
                                  fontFamily: fontMedium,
                                  fontcolor: textColor1,
                                  weight: FontWeight.w500,
                                  max_lines: 2,
                                ),
                              ),
                              VariableText(
                                text: userdata.phoneNumber,
                                fontsize: size.height * 0.02,
                                fontFamily: fontMedium,
                                fontcolor: textColor1.withOpacity(0.8),
                                weight: FontWeight.w500,
                                max_lines: 2,
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: VariableText(
                                  text: "Address",
                                  fontsize: size.height * 0.02,
                                  fontFamily: fontMedium,
                                  fontcolor: textColor1,
                                  weight: FontWeight.w500,
                                  max_lines: 2,
                                ),
                              ),
                              VariableText(
                                text: userdata.country,
                                fontsize: size.height * 0.020,
                                fontFamily: fontMedium,
                                fontcolor: textColor1.withOpacity(0.8),
                                weight: FontWeight.w500,
                                max_lines: 2,
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: VariableText(
                                    text: "Expire Date",
                                    fontsize: size.height * 0.02,
                                    fontFamily: fontMedium,
                                    fontcolor: textColor1,
                                    weight: FontWeight.w500,
                                    max_lines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  SwipeLeftAnimationRoute(
                                      milliseconds: 200,
                                      widget: PrivacyPolicyScreen(
                                        heading: "Privacy & Policy",
                                        url: "https://playeon.com/privacy",
                                      )));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: VariableText(
                                    text: "Privacy & Policy",
                                    fontsize: size.height * 0.02,
                                    fontFamily: fontMedium,
                                    fontcolor: textColor1,
                                    weight: FontWeight.w500,
                                    max_lines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  SwipeLeftAnimationRoute(
                                      milliseconds: 200,
                                      widget: PrivacyPolicyScreen(
                                        heading:"Terms & Conditions",
                                        url:
                                            "https://playeon.com/terms&condtion",
                                      )));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: VariableText(
                                    text: "Terms & Conditions",
                                    fontsize: size.height * 0.02,
                                    fontFamily: fontMedium,
                                    fontcolor: textColor1,
                                    weight: FontWeight.w500,
                                    max_lines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyButton(
                                btnHeight: size.height * 0.055,
                                btnWidth: size.width * 0.70,
                                btnTxt: "Sign Out",
                                btnColor: Colors.white,
                                btnRadius: 25,
                                borderColor: textColor1,
                                txtColor: textColor5,
                                fontSize: 15,
                                onTap: () async {
                                  LocalPreference pref = LocalPreference();
                                  await pref.removeUser();
                                  await Navigator.push(
                                      context,
                                      SwipeLeftAnimationRoute(
                                          milliseconds: 200,
                                          widget: LoginScreen()));
                                },
                              ),
                            ],
                          ),

                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     MyButton(
                          //       btnHeight: size.height * 0.055,
                          //       btnWidth: size.width * 0.70,
                          //       btnTxt: "Feedback",
                          //       btnColor: Colors.white,
                          //       btnRadius: 25,
                          //       borderColor: textColor1,
                          //       txtColor: textColor5,
                          //       fontSize: 15,
                          //       onTap: () async {
                          //         await Navigator.push(
                          //             context,
                          //             SwipeLeftAnimationRoute(
                          //                 milliseconds: 200,
                          //                 widget: FeedbackScreen()));
                          //       },
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: size.height * 0.01,
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     MyButton(
                          //       btnHeight: size.height * 0.055,
                          //       btnWidth: size.width * 0.70,
                          //       btnTxt: "Movie Request",
                          //       btnColor: Colors.white,
                          //       btnRadius: 25,
                          //       borderColor: textColor1,
                          //       txtColor: textColor5,
                          //       fontSize: 15,
                          //       onTap: () async {
                          //         await Navigator.push(
                          //             context,
                          //             SwipeLeftAnimationRoute(
                          //                 milliseconds: 200,
                          //                 widget: RequestMovieScreen()));
                          //       },
                          //     ),
                          //   ],
                          // )
                          // Container(
                          //   width: size.width,
                          //   height: size.height * 0.6,
                          //   padding: EdgeInsets.symmetric(
                          //       vertical: size.height * verticalPadding),
                          //   child: Column(
                          //     children: [
                          //       Expanded(
                          //         child: GridView.builder(
                          //             itemCount: images.length,
                          //             gridDelegate:
                          //                 SliverGridDelegateWithFixedCrossAxisCount(
                          //               crossAxisCount: 6,
                          //               crossAxisSpacing: size.width * 0.03,
                          //               mainAxisSpacing: size.height * 0.015,
                          //               // childAspectRatio: 0.63,
                          //               childAspectRatio:
                          //                   size.width / (size.height * 0.9),
                          //             ),
                          //             shrinkWrap: false,
                          //             scrollDirection: Axis.vertical,
                          //             physics: ScrollPhysics(),
                          //             itemBuilder: (_, index) {
                          //               return Container(
                          //                   child: Image.asset(images[index]));
                          //             }),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}

class CustomProfileBox extends StatelessWidget {
  String? title;
  String? subtitle;
  CustomProfileBox({super.key, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.23,
      height: size.width * 0.22,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: textColor1, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          VariableText(
            text: title,
            fontcolor: primaryColor1,
            fontsize: size.height * 0.018,
            fontFamily: fontMedium,
            weight: FontWeight.w600,
          ),
          SizedBox(height: 10),
          Column(
            children: [
              VariableText(
                text: subtitle,
                fontcolor: textColor5,
                fontsize: size.height * 0.017,
                fontFamily: fontMedium,
                weight: FontWeight.w500,
                max_lines: 2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
