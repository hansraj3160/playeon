import 'package:flutter/material.dart';
import 'package:playeon/dashboard/series_about.dart';
import 'package:playeon/dashboard/videoplayer.dart';
import 'package:shimmer/shimmer.dart';
import '../auth/api_controller.dart';
import '../models/series_model.dart';
import '../widgets/common.dart';
import '../widgets/style.dart';
import 'about.dart';
import 'local_preference_controller.dart';

class Series extends StatefulWidget {
  const Series({super.key});

  @override
  State<Series> createState() => _SeriesState();
}

class _SeriesState extends State<Series> {
  @override
  bool isLoading = false;
  setLoading(bool loading) {
    if (mounted) {
      setState(() {
        isLoading = loading;
      });
    }
  }

  List<SeriesModel> moviesData = [];
  void updateList(String value) {}
  getSeriesData() async {
    setLoading(true);
    LocalPreference prefs = LocalPreference();
    String token = await prefs.getUserToken();
    var response = await ApiController().getSeries(token);

    print(" form api $response");
    for (var item in response) {
      moviesData.add(SeriesModel.fromJson(item));
    }
    setLoading(false);
  }

  @override
  void initState() {
    getSeriesData();
    super.initState();
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
                            text: "All Series ",
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
                        child: isLoading
                            ? GridView.builder(
                                itemCount: moviesData.length,
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
                                  return Shimmer.fromColors(
                                      baseColor: Colors.grey[200]!,
                                      highlightColor: Colors.grey[200]!,
                                      period: Duration(milliseconds: 1000),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(size.height * 0.02),
                                          ),
                                        ),
                                        child: Container(
                                          height: size.height * 0.16,
                                          //width: size.width * 0.62,
                                          margin: EdgeInsets.only(
                                              top: size.height * 0.02),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.width * 0.01,
                                              vertical: size.height * 0.01),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).cardColor,
                                            //color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.white
                                                    .withOpacity(0.1),
                                                blurRadius: 20.0,
                                                spreadRadius: 0,
                                                offset: const Offset(
                                                  4.0, // horizontal, move right 10
                                                  5.0, // vertical, move down 10
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ));
                                },
                              )
                            : GridView.builder(
                                itemCount: moviesData.length,
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
                                                widget: SeriesAbout(
                                                  movieData: moviesData[index],
                                                )));
                                      },
                                      child: Image.network(
                                          moviesData[index].imgSmPoster!));
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
