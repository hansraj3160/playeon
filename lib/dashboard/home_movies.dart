import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:playeon/dashboard/about.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../auth/api_controller.dart';
import '../models/movies_model.dart';
import '../provider/filter_movies.dart';
import '../widgets/common.dart';
import '../widgets/style.dart';

import '../services/local_preference_controller.dart';
import 'searchscreen.dart';

class HomeMoviesScreen extends StatefulWidget {
  const HomeMoviesScreen({super.key});

  @override
  State<HomeMoviesScreen> createState() => _HomeMoviesScreenState();
}

class _HomeMoviesScreenState extends State<HomeMoviesScreen> {
  int currentIndex = 0;
  String? categoryController;
  CarouselController _controller = CarouselController();

  @override
  bool isLoading = false;
  setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  List<MoviesModel> moviesDat = [];

  @override
  void initState() {
    getMovies();
    super.initState();
  }

  getMovies() async {
    var movies =
        Provider.of<MoviesGenraProvider>(context, listen: false).homeMovies;
    if (movies.isEmpty) {
      setLoading(true);
      LocalPreference prefs = LocalPreference();
      String token = await prefs.getUserToken();
      var response = await ApiController().getMovies(token);
//
      // print(" form api $response");
      for (var item in response) {
        moviesDat.add(MoviesModel.fromJson(item));
      }
      Provider.of<MoviesGenraProvider>(context, listen: false)
          .setHomeMovies(moviesDat);
      setLoading(false);
    }
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var moviesData = Provider.of<MoviesGenraProvider>(context).homeMovies;
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            SizedBox(width: size.width * 0.04),
                            Image.asset(
                              "assets/icons/logo.png",
                              scale: 2,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              SwipeLeftAnimationRoute(
                                  milliseconds: 200, widget: searchscreen()));
                        },
                        icon: Icon(
                          Icons.search,
                          color: textColor1,
                        ),
                      ),
                      // MyPopupMenu(),
                      // InkWell(
                      //   onTap: () {
                      //     Navigator.push(
                      //         context,
                      //         SwipeLeftAnimationRoute(
                      //             milliseconds: 200, widget: Profile()));
                      //   },
                      //   child: SizedBox(
                      //     height: size.height * 0.05,
                      //     width: size.height * 0.05,
                      //     child: ClipRRect(
                      //       borderRadius: BorderRadius.circular(8),
                      //       child: Image.network(
                      //         userdata!.profilePicture!,
                      //         scale: 5,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(width: size.width * 0.04)
                    ],
                  ),
                  // SizedBox(
                  //   height: size.height * 0.02,
                  // ),
                  // CarouselSlider(
                  //   options: CarouselOptions(
                  //       aspectRatio: 2.1,
                  //       autoPlay: true,
                  //       enlargeCenterPage: true,
                  //       viewportFraction: 0.31,
                  //       enlargeFactor: 0.3),
                  //   items: List.generate(
                  //       itemImages.length,
                  //       (index) => InkWell(
                  //             onTap: () {
                  //               Navigator.push(
                  //                   context,
                  //                   SwipeLeftAnimationRoute(
                  //                       milliseconds: 200,
                  //                       widget: About(
                  //                         movieData: moviesData[index],
                  //                       )));
                  //             },
                  //             child: Container(
                  //               width: size.width * 0.6,
                  //               child: ClipRRect(
                  //                   borderRadius: BorderRadius.circular(10.0),
                  //                   child: Image.network(
                  //                       moviesData[index].imgSmPoster!,
                  //                       fit: BoxFit.cover)),
                  //             ),
                  //           )),
                  //   carouselController: _controller,
                  // ),
                  // SizedBox(
                  //   height: size.height * 0.04,
                  // ),
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
                                crossAxisCount: 4,
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
                                    crossAxisCount: 3,
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
                                                widget: About(
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
