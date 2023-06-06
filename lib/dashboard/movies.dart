import 'package:flutter/material.dart';
import 'package:playeon/models/movies_model.dart';
import '../widgets/common.dart';
import '../widgets/style.dart';
import 'about.dart';
import 'videoplayer.dart';

class Movies extends StatefulWidget {
  List<MoviesModel>? moviesData;
  Movies({super.key, this.moviesData});

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  @override
  bool isLoading = false;
  setLoading(bool loading) {
    if (mounted) {
      setState(() {
        isLoading = loading;
      });
    }
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(children: [
                Image.asset(
                  "assets/images/about_img.png",
                  height: 350,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 15),
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
                                      fontcolor: primaryColorW,
                                      fontsize: size.height * 0.022,
                                      fontFamily: fontSemiBold,
                                      textAlign: TextAlign.start,
                                      weight: FontWeight.w500,
                                    ),
                                  ]),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 280,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          VariableText(
                            text: "All Movies ",
                            fontsize: size.height * 0.020,
                            fontcolor: textColor1,
                            weight: FontWeight.w500,
                            fontFamily: fontRegular,
                            underlined: true,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      child: Container(
                        width: size.width,
                        height: size.height * 0.5,
                        padding: EdgeInsets.symmetric(
                            vertical: size.height * verticalPadding),
                        child: GridView.builder(
                            itemCount: widget.moviesData!.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 6,
                              crossAxisSpacing: size.width * 0.03,
                              mainAxisSpacing: size.height * 0.015,
                              // childAspectRatio: 0.63,
                              childAspectRatio:
                                  size.width / (size.height * 0.9),
                            ),
                            shrinkWrap: false,
                            scrollDirection: Axis.vertical,
                            physics: ScrollPhysics(),
                            itemBuilder: (_, index) {
                              return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        SwipeLeftAnimationRoute(
                                            milliseconds: 200,
                                            widget: About(
                                              movieData:
                                                  widget.moviesData![index],
                                            )));
                                  },
                                  child: Image.network(
                                      widget.moviesData![index].imgSmPoster!));
                            }),
                      ),
                    )
                  ],
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
