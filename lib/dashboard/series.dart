import 'package:flutter/material.dart';
import 'package:playeon/dashboard/series_about.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../auth/api_controller.dart';
import '../models/series_model.dart';
import '../provider/filter_movies.dart';
import '../widgets/common.dart';
import '../widgets/style.dart';

import '../services/local_preference_controller.dart';

class Series extends StatefulWidget {
  const Series({super.key});

  @override
  State<Series> createState() => _SeriesState();
}

class _SeriesState extends State<Series> {
  @override
  bool isLoading = false;
  setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  List<SeriesModel> moviesDat = [];
  void updateList(String value) {}
  getSeriesData() async {
    var movies =
        Provider.of<MoviesGenraProvider>(context, listen: false).seriesData;
    if (movies.isEmpty) {
      setLoading(true);
      LocalPreference prefs = LocalPreference();
      String token = await prefs.getUserToken();
      var response = await ApiController().getSeries(token);

      for (var item in response) {
        moviesDat.add(SeriesModel.fromJson(item));
      }
      Provider.of<MoviesGenraProvider>(context, listen: false)
          .setSeries(moviesDat);
      setLoading(false);
    }
  }

  @override
  void initState() {
    getSeriesData();
    super.initState();
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var moviesData =
        Provider.of<MoviesGenraProvider>(context, listen: false).seriesData;

    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: backgroundColor,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: size.height * verticalPadding),
                      child: isLoading
                          ? GridView.builder(
                              itemCount: moviesData.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: size.width * 0.03,
                                mainAxisSpacing: size.height * 0.015,
                                // childAspectRatio: 0.63,
                                childAspectRatio:
                                    size.width / (size.height * 0.9),
                              ),
                              shrinkWrap: true,
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
                                          color: primaryColorW,
                                          //color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.white.withOpacity(0.1),
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
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GridView.builder(
                                  itemCount: moviesData.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    crossAxisSpacing: size.width * 0.03,
                                    mainAxisSpacing: size.height * 0.015,
                                    // childAspectRatio: 0.63,
                                    childAspectRatio:
                                        size.width / (size.height * 0.7),
                                  ),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: BouncingScrollPhysics(),
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
                                      child: Container(
                                          height: size.height * 0.1,
                                          width: size.width * 0.3,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                                moviesData[index].imgSmPoster!,
                                                fit: BoxFit.cover),
                                          )),
                                    );
                                  }),
                            ),
                    ),
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
