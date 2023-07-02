// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:playeon/auth/api_controller.dart';
import 'package:playeon/dashboard/profile.dart';
import 'package:playeon/dashboard/requestMovie/requestMovie.dart';
import 'package:playeon/dashboard/searchscreen.dart';
import 'package:playeon/dashboard/show_all.dart';
import 'package:playeon/models/movies_model.dart';
import 'package:playeon/widgets/common.dart';
import 'package:playeon/widgets/style.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../provider/filter_movies.dart';
import '../provider/user_provider.dart';
import 'about.dart';
import '../services/local_preference_controller.dart';
import 'feedback/feedback.dart';

List<String> itemImages = [
  "assets/images/img_c1.jpg",
  "assets/images/img_c2.jpg",
  "assets/images/img_c3.jpg",
  "assets/images/img_c4.jpg"
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  String? categoryController;
  CarouselController _controller = CarouselController();

  List<MoviesModel> categoryList = [];
  List<MoviesModel> imagefor = [];

  List<MoviesModel> dramasList = [];
  List<MoviesModel> actionList = [];

  List<MoviesModel> thrillerList = [];
  List<MoviesModel> romanticList = [];
  List<MoviesModel> Sci = [];

  List<MoviesModel> crimeList = [];
  List<MoviesModel> comediesList = [];
  List<MoviesModel> horror = [];

  List<MoviesModel> adv = [];
  List<MoviesModel> animat = [];
  List<MoviesModel> moviesData = [];
  List<MoviesModel> categories = [];
  List<String> categorieslist = [];
  void updateList(String value) {}
  bool isLoading = false;
  setLoading(bool loading) {
    if (mounted) {
      setState(() {
        isLoading = loading;
      });
    }
  }

  getMovies() async {
    setLoading(true);
    LocalPreference prefs = LocalPreference();
    String token = await prefs.getUserToken();
    var response = await ApiController().getMovies(token);
//
    // print(" form api $response");
    for (var item in response) {
      moviesData.add(MoviesModel.fromJson(item));
    }
    Provider.of<MoviesGenraProvider>(context, listen: false)
        .setMovies(moviesData);
    setLoading(false);
  }

  @override
  void initState() {
    getMovies();
    getCategories();
    sciFic();
    horrorMovies();
    thriller();
    horrorMovies();
    action();
    romance();
    dramas();
    comedries();
    super.initState();
  }

  getCategories() async {
    setLoading(true);
    LocalPreference prefs = LocalPreference();
    String token = await prefs.getUserToken();
    var response = await ApiController().getMovies(token);

    // print(" form api $response");
    for (var item in response) {
      categories.add(MoviesModel.fromJson(item));
      dynamic genre = item['genre'][0];
      if (genre is List<dynamic> && genre.isNotEmpty) {
        var m = genre;

        addUniqueItem(m[0]);
      } else {
        print('Invalid genre');
      }
    }
    setLoading(false);
  }

  void addUniqueItem(String item) {
    if (!categorieslist.contains(item)) {
      categorieslist.add(item);
      // print('Item added: $item');
    } else {
      // print('Item already exists: $item');
    }
  }

  //Categories data

  sciFic() async {
    setLoading(true);
    LocalPreference prefs = LocalPreference();
    String token = await prefs.getUserToken();
    var response = await ApiController().getCategories(token, "sci-fi");
    for (var item in response) {
      Sci.add(MoviesModel.fromJson(item));
    }
    setLoading(false);
  }

  thriller() async {
    setLoading(true);
    LocalPreference prefs = LocalPreference();
    String token = await prefs.getUserToken();
    var response = await ApiController().getCategories(token, "thriller");
    for (var item in response) {
      thrillerList.add(MoviesModel.fromJson(item));
    }
    setLoading(false);
  }

  action() async {
    setLoading(true);
    LocalPreference prefs = LocalPreference();
    String token = await prefs.getUserToken();
    var response = await ApiController().getCategories(token, "action");
    for (var item in response) {
      actionList.add(MoviesModel.fromJson(item));
    }
    setLoading(false);
  }

  romance() async {
    setLoading(true);
    LocalPreference prefs = LocalPreference();
    String token = await prefs.getUserToken();
    var response = await ApiController().getCategories(token, "romance");
    for (var item in response) {
      romanticList.add(MoviesModel.fromJson(item));
    }
    setLoading(false);
  }

  dramas() async {
    setLoading(true);
    LocalPreference prefs = LocalPreference();
    String token = await prefs.getUserToken();
    var response = await ApiController().getCategories(token, "dramas");
    for (var item in response) {
      dramasList.add(MoviesModel.fromJson(item));
    }
    setLoading(false);
  }

  crime() async {
    setLoading(true);
    LocalPreference prefs = LocalPreference();
    String token = await prefs.getUserToken();
    var response = await ApiController().getCategories(token, "crime");
    for (var item in response) {
      crimeList.add(MoviesModel.fromJson(item));
    }
    setLoading(false);
  }

  horrorMovies() async {
    setLoading(true);
    LocalPreference prefs = LocalPreference();
    String token = await prefs.getUserToken();
    var response = await ApiController().getCategories(token, "horror");
    for (var item in response) {
      horror.add(MoviesModel.fromJson(item));
    }
    setLoading(false);
  }

  comedries() async {
    setLoading(true);
    LocalPreference prefs = LocalPreference();
    String token = await prefs.getUserToken();
    var response = await ApiController().getCategories(token, "comedies");

    for (var item in response) {
      comediesList.add(MoviesModel.fromJson(item));
    }
    setLoading(false);
  }

  // final List<Widget> imageSliders =
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    User? userdata = Provider.of<UserProvider>(context).user;
    var movies = Provider.of<MoviesGenraProvider>(context).moviesGenra;
    return Stack(
      children: [
        SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 5),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            SwipeLeftAnimationRoute(
                                milliseconds: 200, widget: Profile()));
                      },
                      child: SizedBox(
                        height: size.height * 0.05,
                        width: size.height * 0.05,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            userdata!.profilePicture!,
                            scale: 5,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: size.width * 0.04)
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                CarouselSlider(
                  options: CarouselOptions(
                      aspectRatio: 2.5,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.26,
                      enlargeFactor: 0.3),
                  items: List.generate(
                      itemImages.length,
                      (index) => InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  SwipeLeftAnimationRoute(
                                      milliseconds: 200,
                                      widget: About(
                                        movieData: movies[index],
                                      )));
                            },
                            child: Container(
                              width: size.width * 0.6,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                      movies[index].imgLgPoster!,
                                      fit: BoxFit.cover)),
                            ),
                          )),
                  carouselController: _controller,
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),

                Row(
                  children: [
                    Expanded(
                      child: VariableText(
                        text: "For You",
                        fontcolor: primaryColorW,
                        fontsize: size.height * 0.02,
                        fontFamily: fontMedium,
                        weight: FontWeight.w500,
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          SwipeLeftAnimationRoute(
                              milliseconds: 300,
                              widget: ShowAllMovies(
                                  showList: moviesData, title: "For You"))),
                      child: Row(
                        children: [
                          VariableText(
                            text: "See All",
                            fontcolor: primaryColorW,
                            fontsize: size.height * 0.016,
                            fontFamily: fontMedium,
                            weight: FontWeight.w500,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: primaryColorW,
                            size: 17,
                          )
                        ],
                      ),
                    ),
                  ],
                ),

                Container(
                  width: size.width,
                  height: size.height * 0.22,
                  padding: EdgeInsets.symmetric(
                      vertical: size.height * verticalPadding),
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: moviesData.length,
                            shrinkWrap: false,
                            scrollDirection: Axis.horizontal,
                            physics: ScrollPhysics(),
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
                                    width: size.width * 0.24,
                                    padding: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                          moviesData[index].imgSmPoster!,
                                          fit: BoxFit.cover),
                                    )),
                              );
                            }),
                      )
                    ],
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: VariableText(
                        text: "Continue Watching For",
                        fontcolor: primaryColorW,
                        fontsize: size.height * 0.02,
                        fontFamily: fontMedium,
                        weight: FontWeight.w500,
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          SwipeLeftAnimationRoute(
                              milliseconds: 300,
                              widget: ShowAllMovies(
                                  showList: dramasList,
                                  title: " Continue Watching"))),
                      child: Row(
                        children: [
                          VariableText(
                            text: "See All",
                            fontcolor: primaryColorW,
                            fontsize: size.height * 0.016,
                            fontFamily: fontMedium,
                            weight: FontWeight.w500,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: primaryColorW,
                            size: 17,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.22,
                  padding: EdgeInsets.symmetric(
                      vertical: size.height * verticalPadding),
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: thrillerList.length,
                            shrinkWrap: false,
                            scrollDirection: Axis.horizontal,
                            physics: ScrollPhysics(),
                            itemBuilder: (_, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      SwipeLeftAnimationRoute(
                                          milliseconds: 200,
                                          widget: About(
                                            movieData: thrillerList[index],
                                          )));
                                },
                                child: Container(
                                    height: size.height * 0.1,
                                    width: size.width * 0.24,
                                    padding: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                          thrillerList[index].imgSmPoster!,
                                          fit: BoxFit.cover),
                                    )),
                              );
                            }),
                      )
                    ],
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: VariableText(
                        text: "Action",
                        fontcolor: primaryColorW,
                        fontsize: size.height * 0.02,
                        fontFamily: fontMedium,
                        weight: FontWeight.w500,
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          SwipeLeftAnimationRoute(
                              milliseconds: 300,
                              widget: ShowAllMovies(
                                  showList: actionList,
                                  title: "Action Movies"))),
                      child: Row(
                        children: [
                          VariableText(
                            text: "See All",
                            fontcolor: primaryColorW,
                            fontsize: size.height * 0.016,
                            fontFamily: fontMedium,
                            weight: FontWeight.w500,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: primaryColorW,
                            size: 17,
                          )
                        ],
                      ),
                    ),
                  ],
                ),

                Container(
                  width: size.width,
                  height: size.height * 0.22,
                  padding: EdgeInsets.symmetric(
                      vertical: size.height * verticalPadding),
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: actionList.length,
                            shrinkWrap: false,
                            scrollDirection: Axis.horizontal,
                            physics: ScrollPhysics(),
                            itemBuilder: (_, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      SwipeLeftAnimationRoute(
                                          milliseconds: 200,
                                          widget: About(
                                            movieData: actionList[index],
                                          )));
                                },
                                child: Container(
                                    height: size.height * 0.1,
                                    width: size.width * 0.24,
                                    padding: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                          actionList[index].imgSmPoster!,
                                          fit: BoxFit.cover),
                                    )),
                              );
                            }),
                      )
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: VariableText(
                        text: "Dramas",
                        fontcolor: primaryColorW,
                        fontsize: size.height * 0.02,
                        fontFamily: fontMedium,
                        weight: FontWeight.w500,
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          SwipeLeftAnimationRoute(
                              milliseconds: 300,
                              widget: ShowAllMovies(
                                  showList: dramasList, title: "Now list"))),
                      child: Row(
                        children: [
                          VariableText(
                            text: "See All",
                            fontcolor: primaryColorW,
                            fontsize: size.height * 0.016,
                            fontFamily: fontMedium,
                            weight: FontWeight.w500,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: primaryColorW,
                            size: 17,
                          )
                        ],
                      ),
                    ),
                  ],
                ),

                Container(
                  width: size.width,
                  height: size.height * 0.22,
                  padding: EdgeInsets.symmetric(
                      vertical: size.height * verticalPadding),
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: dramasList.length,
                            shrinkWrap: false,
                            scrollDirection: Axis.horizontal,
                            physics: ScrollPhysics(),
                            itemBuilder: (_, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      SwipeLeftAnimationRoute(
                                          milliseconds: 200,
                                          widget: About(
                                            movieData: dramasList[index],
                                          )));
                                },
                                child: Container(
                                    height: size.height * 0.1,
                                    width: size.width * 0.24,
                                    padding: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                          dramasList[index].imgSmPoster!,
                                          fit: BoxFit.cover),
                                    )),
                              );
                            }),
                      )
                    ],
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: VariableText(
                        text: "Comedies",
                        fontcolor: primaryColorW,
                        fontsize: size.height * 0.02,
                        fontFamily: fontMedium,
                        weight: FontWeight.w500,
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          SwipeLeftAnimationRoute(
                              milliseconds: 300,
                              widget: ShowAllMovies(
                                  showList: comediesList, title: "Now list"))),
                      child: Row(
                        children: [
                          VariableText(
                            text: "See All",
                            fontcolor: primaryColorW,
                            fontsize: size.height * 0.016,
                            fontFamily: fontMedium,
                            weight: FontWeight.w500,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: primaryColorW,
                            size: 17,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: size.height * 0.02,
                // ),
                Container(
                  width: size.width,
                  height: size.height * 0.22,
                  padding: EdgeInsets.symmetric(
                      vertical: size.height * verticalPadding),
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: comediesList.length,
                            shrinkWrap: false,
                            scrollDirection: Axis.horizontal,
                            physics: ScrollPhysics(),
                            itemBuilder: (_, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      SwipeLeftAnimationRoute(
                                          milliseconds: 200,
                                          widget: About(
                                            movieData: comediesList[index],
                                          )));
                                },
                                child: Container(
                                    height: size.height * 0.1,
                                    width: size.width * 0.24,
                                    padding: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                          comediesList[index].imgSmPoster!,
                                          fit: BoxFit.cover),
                                    )),
                              );
                            }),
                      )
                    ],
                  ),
                ),
                // SizedBox(
                //   height: size.height * 0.03,
                // ),
                Row(
                  children: [
                    Expanded(
                      child: VariableText(
                        text: "Sci-Fi",
                        fontcolor: primaryColorW,
                        fontsize: size.height * 0.02,
                        fontFamily: fontMedium,
                        weight: FontWeight.w500,
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          SwipeLeftAnimationRoute(
                              milliseconds: 300,
                              widget: ShowAllMovies(
                                  showList: Sci, title: "Sci_Fi Movies"))),
                      child: Row(
                        children: [
                          VariableText(
                            text: "See All",
                            fontcolor: primaryColorW,
                            fontsize: size.height * 0.016,
                            fontFamily: fontMedium,
                            weight: FontWeight.w500,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: primaryColorW,
                            size: 17,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: size.height * 0.02,
                // ),
                Container(
                  width: size.width,
                  height: size.height * 0.22,
                  padding: EdgeInsets.symmetric(
                      vertical: size.height * verticalPadding),
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: Sci.length,
                            shrinkWrap: false,
                            scrollDirection: Axis.horizontal,
                            physics: ScrollPhysics(),
                            itemBuilder: (_, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      SwipeLeftAnimationRoute(
                                          milliseconds: 200,
                                          widget: About(
                                            movieData: Sci[index],
                                          )));
                                },
                                child: Container(
                                    height: size.height * 0.1,
                                    width: size.width * 0.24,
                                    padding: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                          Sci[index].imgSmPoster!,
                                          fit: BoxFit.cover),
                                    )),
                              );
                            }),
                      )
                    ],
                  ),
                ),
                // SizedBox(
                //   height: size.height * 0.03,
                // ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: VariableText(
                //         text: "Kids Cartoon",
                //         fontcolor: primaryColorW,
                //         fontsize: size.height * 0.02,
                //         fontFamily: fontMedium,
                //         weight: FontWeight.w500,
                //       ),
                //     ),
                //     InkWell(
                //       onTap: () => Navigator.push(
                //           context,
                //           SwipeLeftAnimationRoute(
                //               milliseconds: 300,
                //               widget: ShowAllMovies(
                //                   showList: moviesData, title: "Cartoons"))),
                //       child: Row(
                //         children: [
                //           VariableText(
                //             text: "See All",
                //             fontcolor: primaryColorW,
                //             fontsize: size.height * 0.016,
                //             fontFamily: fontMedium,
                //             weight: FontWeight.w500,
                //           ),
                //           const Icon(
                //             Icons.arrow_forward_ios,
                //             color: primaryColorW,
                //             size: 17,
                //           )
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: size.height * 0.02,
                // ),
                // Container(
                //   width: size.width,
                //   height: size.height * 0.18,
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: ListView.builder(
                //             itemCount: kid.length,
                //             shrinkWrap: false,
                //             scrollDirection: Axis.horizontal,
                //             physics: ScrollPhysics(),
                //             itemBuilder: (_, index) {
                //               return Container(
                //                 padding: EdgeInsets.only(right: 1),
                //                 // child: Image.asset(kid[index])
                //               );
                //             }),
                //       )
                //     ],
                //   ),
                // ),
                Row(
                  children: [
                    Expanded(
                      child: VariableText(
                        text: "Romantic",
                        fontcolor: primaryColorW,
                        fontsize: size.height * 0.02,
                        fontFamily: fontMedium,
                        weight: FontWeight.w500,
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          SwipeLeftAnimationRoute(
                              milliseconds: 300,
                              widget: ShowAllMovies(
                                  showList: romanticList,
                                  title: "Romantic Movies"))),
                      child: Row(
                        children: [
                          VariableText(
                            text: "See All",
                            fontcolor: primaryColorW,
                            fontsize: size.height * 0.016,
                            fontFamily: fontMedium,
                            weight: FontWeight.w500,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: primaryColorW,
                            size: 17,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: size.height * 0.02,
                // ),
                Container(
                  width: size.width,
                  height: size.height * 0.22,
                  padding: EdgeInsets.symmetric(
                      vertical: size.height * verticalPadding),
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: romanticList.length,
                            shrinkWrap: false,
                            scrollDirection: Axis.horizontal,
                            physics: ScrollPhysics(),
                            itemBuilder: (_, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      SwipeLeftAnimationRoute(
                                          milliseconds: 200,
                                          widget: About(
                                            movieData: romanticList[index],
                                          )));
                                },
                                child: Container(
                                    height: size.height * 0.1,
                                    width: size.width * 0.24,
                                    padding: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                          romanticList[index].imgSmPoster!,
                                          fit: BoxFit.cover),
                                    )),
                              );
                            }),
                      )
                    ],
                  ),
                ),
                // SizedBox(
                //   height: size.height * 0.03,
                // ),
                Row(
                  children: [
                    Expanded(
                      child: VariableText(
                        text: "Horror",
                        fontcolor: primaryColorW,
                        fontsize: size.height * 0.02,
                        fontFamily: fontMedium,
                        weight: FontWeight.w500,
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          SwipeLeftAnimationRoute(
                              milliseconds: 300,
                              widget: ShowAllMovies(
                                  showList: horror, title: "Horror Movies"))),
                      child: Row(
                        children: [
                          VariableText(
                            text: "See All",
                            fontcolor: primaryColorW,
                            fontsize: size.height * 0.016,
                            fontFamily: fontMedium,
                            weight: FontWeight.w500,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: primaryColorW,
                            size: 17,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: size.height * 0.02,
                // ),
                Container(
                  width: size.width,
                  height: size.height * 0.22,
                  padding: EdgeInsets.symmetric(
                      vertical: size.height * verticalPadding),
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: horror.length,
                            shrinkWrap: false,
                            scrollDirection: Axis.horizontal,
                            physics: ScrollPhysics(),
                            itemBuilder: (_, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      SwipeLeftAnimationRoute(
                                          milliseconds: 200,
                                          widget: About(
                                            movieData: horror[index],
                                          )));
                                },
                                child: Container(
                                    height: size.height * 0.1,
                                    width: size.width * 0.24,
                                    padding: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                          horror[index].imgSmPoster!,
                                          fit: BoxFit.cover),
                                    )),
                              );
                            }),
                      )
                    ],
                  ),
                ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: VariableText(
                //         text: "Adventure",
                //         fontcolor: primaryColorW,
                //         fontsize: size.height * 0.02,
                //         fontFamily: fontMedium,
                //         weight: FontWeight.w500,
                //       ),
                //     ),
                //     InkWell(
                //       onTap: () => Navigator.push(
                //           context,
                //           SwipeLeftAnimationRoute(
                //               milliseconds: 300,
                //               widget: ShowAllMovies(
                //                   showList: moviesData,
                //                   title: "Adventure Movies"))),
                //       child: Row(
                //         children: [
                //           VariableText(
                //             text: "See All",
                //             fontcolor: primaryColorW,
                //             fontsize: size.height * 0.016,
                //             fontFamily: fontMedium,
                //             weight: FontWeight.w500,
                //           ),
                //           const Icon(
                //             Icons.arrow_forward_ios,
                //             color: primaryColorW,
                //             size: 17,
                //           )
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: size.height * 0.02,
                // ),
                // Container(
                //   width: size.width,
                //   height: size.height * 0.18,
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: ListView.builder(
                //             itemCount: adv.length,
                //             shrinkWrap: false,
                //             scrollDirection: Axis.horizontal,
                //             physics: ScrollPhysics(),
                //             itemBuilder: (_, index) {
                //               return Container(
                //                 padding: EdgeInsets.only(right: 1),
                //                 // child: Image.asset(adv[index])
                //               );
                //             }),
                //       )
                //     ],
                //   ),
                // ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: VariableText(
                //         text: "Animated Movies",
                //         fontcolor: primaryColorW,
                //         fontsize: size.height * 0.02,
                //         fontFamily: fontMedium,
                //         weight: FontWeight.w500,
                //       ),
                //     ),
                //     InkWell(
                //       onTap: () => Navigator.push(
                //           context,
                //           SwipeLeftAnimationRoute(
                //               milliseconds: 300,
                //               widget: ShowAllMovies(
                //                   showList: moviesData,
                //                   title: "Animated Movies"))),
                //       child: Row(
                //         children: [
                //           VariableText(
                //             text: "See All",
                //             fontcolor: primaryColorW,
                //             fontsize: size.height * 0.016,
                //             fontFamily: fontMedium,
                //             weight: FontWeight.w500,
                //           ),
                //           const Icon(
                //             Icons.arrow_forward_ios,
                //             color: primaryColorW,
                //             size: 17,
                //           )
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: size.height * 0.02,
                ),
              ]),
            ),
          ),
        ),
        if (isLoading) ProcessLoadingLight()
      ],
    );
  }

  Widget buildIndicator(bool isSelected) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: isSelected ? 12 : 8,
        width: isSelected ? 12 : 8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}

class MyPopupMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      offset: Offset(
        100,
        -20,
      ),
      icon: Icon(
        Icons.more_vert,
        color: primaryColorW,
      ),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            value: 1,
            child: Text('Movie Request'),
          ),
          PopupMenuItem(
            value: 2,
            child: Text('Feedback'),
          ),
          PopupMenuItem(
            value: 3,
            child: Text('Profile'),
          ),
        ];
      },
      onSelected: (value) {
        switch (value) {
          case 1:
            Navigator.push(
                context,
                SwipeLeftAnimationRoute(
                    milliseconds: 200, widget: RequestMovieScreen()));
            break;
          case 2:
            Navigator.push(
                context,
                SwipeLeftAnimationRoute(
                    milliseconds: 200, widget: FeedbackScreen()));
            break;
          case 3:
            Navigator.push(context,
                SwipeLeftAnimationRoute(milliseconds: 200, widget: Profile()));
            break;
        }
      },
    );
  }
}
