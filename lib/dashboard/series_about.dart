import 'package:flutter/material.dart';
import 'package:playeon/models/series_model.dart';

import '../models/movies_model.dart';
import '../widgets/common.dart';
import '../widgets/style.dart';
import 'videoplayer.dart';

class SeriesAbout extends StatefulWidget {
  SeriesModel? movieData;
  String? url;
  SeriesAbout({super.key, this.movieData});

  @override
  State<SeriesAbout> createState() => _SeriesAboutState();
}

class _SeriesAboutState extends State<SeriesAbout> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: backgroundColorB,
      body: Stack(children: [
        Image.network(
          widget.movieData!.imgLgPoster!,
          height: 400,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          child: Padding(
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
                  // code for live video icon
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.favorite_border,
                      color: textColor1,
                      size: 35,
                    ),
                  )
                ]),
          ),
        ),
        Positioned(
            top: size.height * 0.35,
            left: 1,
            child: Image.asset("assets/images/img_line.png")),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.5),
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: size.height * horizontalPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VariableText(
                      text: widget.movieData!.title!,
                      fontcolor: textColor1,
                      fontsize: size.height * 0.030,
                      fontFamily: fontMedium,
                      weight: FontWeight.w500,
                    ),
                    SizedBox(height: 5),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        VariableText(
                          text: "${widget.movieData!.duration!}",
                          fontcolor: textColorS,
                          fontsize: size.height * 0.017,
                          fontFamily: fontMedium,
                          weight: FontWeight.w500,
                          // max_lines: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            VariableText(
                              text: "${widget.movieData!.type}",
                              fontcolor: textColorS,
                              fontsize: size.height * 0.017,
                              fontFamily: fontMedium,
                              weight: FontWeight.w500,
                              textAlign: TextAlign.start,
                              // max_lines: 2,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 17,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 17,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 17,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 17,
                        ),
                        Icon(
                          Icons.star,
                          color: textColorS,
                          size: 17,
                        ),
                      ],
                    ),
                    MyButton(
                      btnHeight: size.height * 0.05,
                      btnWidth: size.width * 0.24,
                      borderColor: textColor5,
                      btnColor: textColor5,
                      btnRadius: 200,
                      btnTxt: "Play",
                      fontSize: size.height * 0.020,
                      weight: FontWeight.w500,
                      fontFamily: fontRegular,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VideoPlayers(
                                      url: widget.movieData!.episodes![0].video
                                  )),
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Container(
                        width: size.width * 0.90,
                        height: size.width * 0.30,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              VariableText(
                                text: widget.movieData!.description,
                                fontcolor: textColor1,
                                fontsize: size.height * 0.018,
                                fontFamily: fontRegular,
                                weight: FontWeight.w500,
                                max_lines: 6,
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /*  Padding(
              padding: const EdgeInsets.only(left: 22.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    VariableText(
                      text: "Like & Share",
                      fontcolor: textColor1,
                      fontsize: size.height * 0.024,
                      fontFamily: fontMedium,
                      weight: FontWeight.w500,
                      max_lines: 2,
                    ),
                  ]),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: size.width * 0.15,
                          height: size.width * 0.40,
                          child:
                              // img not found
                              Column(
                            children: [
                              Image.asset(
                                "assets/icons/like_ic.png",
                                height: 50,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Column(
                                children: [
                                  VariableText(
                                    text: "230K",
                                    fontcolor: textColor1,
                                    fontsize: size.height * 0.017,
                                    fontFamily: fontMedium,
                                    weight: FontWeight.w500,
                                    max_lines: 2,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: size.width * 0.15,
                          height: size.width * 0.40,
                          child:
                              // img not found
                              Column(
                            children: [
                              Image.asset(
                                "assets/icons/fav_ic.png",
                                height: 50,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Column(
                                children: [
                                  VariableText(
                                    text: "230K",
                                    fontcolor: textColor1,
                                    fontsize: size.height * 0.017,
                                    fontFamily: fontMedium,
                                    weight: FontWeight.w500,
                                    max_lines: 2,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: size.width * 0.15,
                          height: size.width * 0.40,
                          child:
                              // img not found
                              Column(
                            children: [
                              Image.asset(
                                "assets/icons/comment_ic.png",
                                height: 50,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Column(
                                children: [
                                  VariableText(
                                    text: "230K",
                                    fontcolor: textColor1,
                                    fontsize: size.height * 0.017,
                                    fontFamily: fontMedium,
                                    weight: FontWeight.w500,
                                    max_lines: 2,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]),
                ],
              ),
            ),*/
          ],
        ),
      ]),
    ));
  }
}
