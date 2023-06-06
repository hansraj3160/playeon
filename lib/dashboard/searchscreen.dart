import 'package:flutter/material.dart';
import 'package:playeon/dashboard/movies.dart';
import 'package:playeon/dashboard/show_all.dart';
import 'package:playeon/models/movies_model.dart';
import 'package:playeon/provider/filter_movies.dart';
import 'package:playeon/widgets/style.dart';
import 'package:provider/provider.dart';

import '../auth/api_controller.dart';
import '../widgets/common.dart';
import 'local_preference_controller.dart';

class searchscreen extends StatefulWidget {
  const searchscreen({super.key});

  @override
  State<searchscreen> createState() => _searchscreenState();
}

class _searchscreenState extends State<searchscreen> {
  List<MoviesModel> categories = [];

  bool isLoading = false;
  setLoading(bool loading) {
    if (mounted) {
      setState(() {
        isLoading = loading;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  getCategories(String? category) async {
    setLoading(true);
    LocalPreference prefs = LocalPreference();
    String token = await prefs.getUserToken();
    var response = await ApiController().getCategories(token, category);

    // print(" form api $response");
    for (var item in response) {
      categories.add(MoviesModel.fromJson(item));
    }
    Navigator.push(
        context,
        SwipeLeftAnimationRoute(
            milliseconds: 300,
            widget: Movies(
              moviesData: categories,
            )));
    setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: textColor1,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: textColor1.withOpacity(0),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search Here',
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 40,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MyButton(
                            btnHeight: size.height * 0.05,
                            btnWidth: size.width * 0.2,
                            borderColor: textColor1,
                            btnColor: Colors.transparent,
                            btnRadius: 200,
                            btnTxt: "Action",
                            weight: FontWeight.w300,
                            fontFamily: fontRegular,
                            onTap: () {
                              getCategories("action");
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          MyButton(
                            btnHeight: size.height * 0.05,
                            btnWidth: size.width * 0.2,
                            borderColor: textColor1,
                            btnColor: Colors.transparent,
                            btnRadius: 200,
                            btnTxt: "Sci-Fi",
                            weight: FontWeight.w300,
                            fontFamily: fontRegular,
                            onTap: () {
                              getCategories("sci-fi");
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          MyButton(
                            btnHeight: size.height * 0.05,
                            btnWidth: size.width * 0.2,
                            borderColor: textColor1,
                            btnColor: Colors.transparent,
                            btnRadius: 200,
                            btnTxt: "Anime",
                            weight: FontWeight.w300,
                            fontFamily: fontRegular,
                            onTap: () {
                              getCategories("anime");
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          MyButton(
                            btnHeight: size.height * 0.05,
                            btnWidth: size.width * 0.2,
                            borderColor: textColor1,
                            btnColor: Colors.transparent,
                            btnRadius: 200,
                            btnTxt: "Funny",
                            weight: FontWeight.w300,
                            fontFamily: fontRegular,
                            onTap: () {
                              getCategories("comedies");
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyButton(
                            btnHeight: size.height * 0.05,
                            btnWidth: size.width * 0.2,
                            borderColor: textColor1,
                            btnColor: Colors.transparent,
                            btnRadius: 200,
                            btnTxt: "Horror",
                            weight: FontWeight.w300,
                            fontFamily: fontRegular,
                            onTap: () {
                              getCategories("horror");
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          MyButton(
                            btnHeight: size.height * 0.05,
                            btnWidth: size.width * 0.2,
                            borderColor: textColor1,
                            btnColor: Colors.transparent,
                            btnRadius: 200,
                            btnTxt: "Romantic",
                            weight: FontWeight.w300,
                            onTap: () {
                              getCategories("romance");
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          MyButton(
                            btnHeight: size.height * 0.05,
                            btnWidth: size.width * 0.2,
                            borderColor: textColor1,
                            btnColor: Colors.transparent,
                            btnRadius: 200,
                            btnTxt: "Adventure",
                            weight: FontWeight.w300,
                            onTap: () {
                              getCategories('sci-fi');
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyButton(
                            btnHeight: size.height * 0.05,
                            btnWidth: size.width * 0.2,
                            borderColor: textColor1,
                            btnColor: Colors.transparent,
                            btnRadius: 200,
                            btnTxt: "Thriller",
                            weight: FontWeight.w300,
                            fontFamily: fontRegular,
                            onTap: () {
                              getCategories("thriller");
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          MyButton(
                            btnHeight: size.height * 0.05,
                            btnWidth: size.width * 0.2,
                            borderColor: textColor1,
                            btnColor: Colors.transparent,
                            btnRadius: 200,
                            btnTxt: "Cartoon",
                            weight: FontWeight.w300,
                            fontFamily: fontRegular,
                            onTap: () {
                              getCategories('dramas');
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyButton(
                            btnHeight: size.height * 0.05,
                            btnWidth: size.width * 0.2,
                            borderColor: textColor1,
                            btnColor: Colors.transparent,
                            btnRadius: 200,
                            btnTxt: "Movies",
                            weight: FontWeight.w300,
                            fontFamily: fontRegular,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  SwipeLeftAnimationRoute(
                                      milliseconds: 300,
                                      widget: Movies(
                                          moviesData:
                                              Provider.of<MoviesGenraProvider>(
                                                      context,
                                                      listen: false)
                                                  .moviesGenra)));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
