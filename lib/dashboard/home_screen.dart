// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:playeon/auth/api_controller.dart';
import 'package:playeon/dashboard/movies.dart';
import 'package:playeon/dashboard/series.dart';
import 'package:playeon/dashboard/show_all.dart';
import 'package:playeon/models/movies_model.dart';
import 'package:playeon/widgets/common.dart';
import 'package:playeon/widgets/style.dart';
import 'package:provider/provider.dart';

import '../provider/filter_movies.dart';
import 'about.dart';
import 'local_preference_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List itemImages = [
    "assets/images/crousel1.png",
    "assets/images/crousel2.png",
    "assets/images/crousel3.png",
  ];
  int currentIndex = 0;
  String? categoryController;
  List<String> categoryList = [
    "Action",
    "Trending now",
    "Anime",
    "Sci-Fi",
    "Kids Cartoon",
    "Romantic",
    "Horror",
    "Adventure",
    "Animated Movies"
  ];
  List<String> imagefor = [
    "assets/images/for1.png",
    "assets/images/for2.png",
    "assets/images/for3.png",
    "assets/images/for4.png",
    "assets/images/img_hotel.png",
    "assets/images/img_hostile.png",
  ];

  List<String> imagecontinue = [
    "assets/images/cont1.png",
    "assets/images/cont2.png",
    "assets/images/cont3.png",
    "assets/images/for4.png",
    "assets/images/img_hotel.png",
    "assets/images/img_hostile.png",
  ];
  List<String> Action = [
    "assets/images/act1.png",
    "assets/images/act2.png",
    "assets/images/act3.png",
    "assets/images/for4.png",
    "assets/images/img_hotel.png",
    "assets/images/img_hostile.png",
  ];

  List<String> trend = [
    "assets/images/trend1.png",
    "assets/images/trend2.png",
    "assets/images/trend3.png",
    "assets/images/trend4.png",
    "assets/images/img_hotel.png",
    "assets/images/img_hostile.png",
  ];
  List<String> Anime = [
    "assets/images/ani1.png",
    "assets/images/ani2.png",
    "assets/images/ani3.png",
    "assets/images/ani4.png",
    "assets/images/img_hotel.png",
    "assets/images/img_hostile.png",
  ];
  List<String> Sci = [
    "assets/images/sci1.png",
    "assets/images/sci2.png",
    "assets/images/sci3.png",
    "assets/images/sci4.png",
    "assets/images/img_hotel.png",
    "assets/images/img_hostile.png",
  ];

  List<String> kid = [
    "assets/images/kid1.png",
    "assets/images/kid2.png",
    "assets/images/kid3.png",
    "assets/images/kid4.png",
    "assets/images/img_hotel.png",
    "assets/images/img_hostile.png",
  ];
  List<String> rom = [
    "assets/images/rom1.png",
    "assets/images/rom2.png",
    "assets/images/rom3.png",
    "assets/images/rom4.png",
    "assets/images/img_hotel.png",
    "assets/images/img_hostile.png",
  ];
  List<String> Horror = [
    "assets/images/hor1.png",
    "assets/images/hor2.png",
    "assets/images/hor3.png",
    "assets/images/hor4.png",
    "assets/images/img_hotel.png",
    "assets/images/img_hostile.png",
  ];

  List<String> adv = [
    "assets/images/adv1.png",
    "assets/images/adv2.png",
    "assets/images/adv3.png",
    "assets/images/adv4.png",
    "assets/images/img_hotel.png",
    "assets/images/img_hostile.png",
  ];
  List<String> animat = [
    "assets/images/animat1.png",
    "assets/images/animat2.png",
    "assets/images/animat3.png",
    "assets/images/animat4.png",
    "assets/images/img_hotel.png",
    "assets/images/img_hostile.png",
  ];
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

    print(" form api $response");
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
        print("Genre ${m[0]}");
        addUniqueItem(m[0]);
      } else {
        print('Invalid genre');
      }
      // categorieslist.add(item['genre'][0]);
    }
    setLoading(false);
  }

  void addUniqueItem(String item) {
    if (!categorieslist.contains(item)) {
      categorieslist.add(item);
      print('Item added: $item');
    } else {
      print('Item already exists: $item');
    }
  }

  List listItem = ["Item 1", "Item 2"];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Stack(
      children: [
        SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 15),
              child: Column(children: [
                Row(
                  children: [
                    Expanded(
                        child: VariableText(
                      text: "MOVIES",
                      fontcolor: primaryColorW,
                      fontsize: size.height * 0.03,
                      fontFamily: fontMedium,
                      weight: FontWeight.w500,
                    )),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.search,
                        color: textColor1,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(
                      btnHeight: size.height * 0.05,
                      btnWidth: size.width * 0.24,
                      borderColor: textColor5,
                      btnColor: textColor5,
                      btnRadius: 200,
                      btnTxt: "Movies",
                      fontSize: size.height * 0.020,
                      weight: FontWeight.w500,
                      fontFamily: fontRegular,
                      onTap: () {
                        Navigator.push(
                            context,
                            SwipeLeftAnimationRoute(
                                milliseconds: 200,
                                widget: Movies(moviesData: moviesData)));
                      },
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    MyButton(
                      btnHeight: size.height * 0.05,
                      btnWidth: size.width * 0.24,
                      borderColor: textColor5,
                      btnColor: textColor5,
                      btnRadius: 200,
                      btnTxt: "Series",
                      fontSize: size.height * 0.020,
                      weight: FontWeight.w500,
                      fontFamily: fontRegular,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Series()),
                        );
                      },
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    Expanded(
                      child: MyDropDown(
                        hinttext: "Categories",
                        width: size.width * 0.2,
                        states: categorieslist,
                        radius: 50,
                        selectedValue: (value) {
                          print(value);

                          categoryController = value;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: PageView.builder(
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index % itemImages.length;
                      });
                    },

                    // itemCount: itemImages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          height: 400,
                          width: double.infinity,
                          child: Image.asset(
                              itemImages[index % itemImages.length],
                              fit: BoxFit.cover),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var i = 0; i < itemImages.length; i++)
                      buildIndicator(currentIndex == i)
                  ],
                ),
                SizedBox(
                  height: 10,
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
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.22,
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
                                    padding: EdgeInsets.only(right: 10),
                                    child: Image.network(
                                        moviesData[index].imgSmPoster!)),
                              );
                            }),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
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
                                  showList: moviesData,
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
                  height: size.height * 0.18,
                  padding: EdgeInsets.symmetric(
                      vertical: size.height * verticalPadding),
                  child: Row(
                    children: [
                      Expanded(
                        child: GridView.builder(
                            itemCount: imagecontinue.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              crossAxisSpacing: size.width * 0.011,
                              mainAxisSpacing: size.height * 0.0001,
                              //childAspectRatio: 0.63,
                              childAspectRatio:
                                  size.width / (size.height * 0.50),
                            ),
                            shrinkWrap: false,
                            scrollDirection: Axis.horizontal,
                            physics: ScrollPhysics(),
                            itemBuilder: (_, index) {
                              return Container(
                                  child: Image.asset(imagecontinue[index]));
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
                                  showList: moviesData,
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
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.18,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: Action.length,
                            shrinkWrap: false,
                            scrollDirection: Axis.horizontal,
                            physics: ScrollPhysics(),
                            itemBuilder: (_, index) {
                              return Container(
                                  padding: EdgeInsets.only(right: 1),
                                  child: Image.asset(Action[index]));
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
                        text: "Trending Now",
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
                                  showList: moviesData, title: "Now list"))),
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
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.18,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: trend.length,
                            shrinkWrap: false,
                            scrollDirection: Axis.horizontal,
                            physics: ScrollPhysics(),
                            itemBuilder: (_, index) {
                              return Container(
                                  padding: EdgeInsets.only(right: 1),
                                  child: Image.asset(trend[index]));
                            }),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: VariableText(
                        text: "Anime",
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
                                  showList: moviesData, title: "Now list"))),
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
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.18,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: Anime.length,
                            shrinkWrap: false,
                            scrollDirection: Axis.horizontal,
                            physics: ScrollPhysics(),
                            itemBuilder: (_, index) {
                              return Container(
                                  padding: EdgeInsets.only(right: 1),
                                  child: Image.asset(Anime[index]));
                            }),
                      )
                    ],
                  ),
                ),
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
                                  showList: moviesData,
                                  title: "Sci_Fi Movies"))),
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
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.18,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: Sci.length,
                            shrinkWrap: false,
                            scrollDirection: Axis.horizontal,
                            physics: ScrollPhysics(),
                            itemBuilder: (_, index) {
                              return Container(
                                  padding: EdgeInsets.only(right: 1),
                                  child: Image.asset(Sci[index]));
                            }),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: VariableText(
                        text: "Kids Cartoon",
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
                                  showList: moviesData, title: "Cartoons"))),
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
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.18,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: kid.length,
                            shrinkWrap: false,
                            scrollDirection: Axis.horizontal,
                            physics: ScrollPhysics(),
                            itemBuilder: (_, index) {
                              return Container(
                                  padding: EdgeInsets.only(right: 1),
                                  child: Image.asset(kid[index]));
                            }),
                      )
                    ],
                  ),
                ),
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
                                  showList: moviesData,
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
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.18,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: rom.length,
                            shrinkWrap: false,
                            scrollDirection: Axis.horizontal,
                            physics: ScrollPhysics(),
                            itemBuilder: (_, index) {
                              return Container(
                                  padding: EdgeInsets.only(right: 1),
                                  child: Image.asset(rom[index]));
                            }),
                      )
                    ],
                  ),
                ),
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
                                  showList: moviesData,
                                  title: "Horror Movies"))),
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
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.18,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: Horror.length,
                            shrinkWrap: false,
                            scrollDirection: Axis.horizontal,
                            physics: ScrollPhysics(),
                            itemBuilder: (_, index) {
                              return Container(
                                  padding: EdgeInsets.only(right: 1),
                                  child: Image.asset(Horror[index]));
                            }),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: VariableText(
                        text: "Adventure",
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
                                  showList: moviesData,
                                  title: "Adventure Movies"))),
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
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.18,
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: adv.length,
                            shrinkWrap: false,
                            scrollDirection: Axis.horizontal,
                            physics: ScrollPhysics(),
                            itemBuilder: (_, index) {
                              return Container(
                                  padding: EdgeInsets.only(right: 1),
                                  child: Image.asset(adv[index]));
                            }),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: VariableText(
                        text: "Animated Movies",
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
                                  showList: moviesData,
                                  title: "Animated Movies"))),
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
