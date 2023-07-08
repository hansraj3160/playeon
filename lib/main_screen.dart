import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:playeon/widgets/common.dart';

import 'dashboard/home_movies.dart';
import 'dashboard/movies_screen.dart';
import 'dashboard/series.dart';
import 'widgets/style.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  var mainTab = {
    "tabs": [
      {"title": "Movies"},
      {"title": "Home"},
      {"title": "Series"},
    ],
  };

  @override
  void initState() {
    super.initState();
    tabController = TabController(
        length: 3,
        animationDuration: const Duration(milliseconds: 400),
        initialIndex: 1,
        vsync: this);
    tabController!.addListener(handleTabSelection);
  }

  handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    tabController!.dispose();
  }

  Future<bool> onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Confirm'),
              content: const Text('Do you want to exit the app?'),
              actions: <Widget>[
                TextButton(
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Yes', style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    exit(0);
                  },
                )
              ],
            );
          },
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: () => onWillPop(),
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: TabBarView(
            controller: tabController,
            dragStartBehavior: DragStartBehavior.start,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              HomeScreen(),
              HomeMoviesScreen(),
              Series(),

              // MyPopupMenu(),
            ],
          ),
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: size.height * 0.06,
                  decoration: BoxDecoration(color: backgroundColor),
                  child: TabBar(
                      controller: tabController,
                      indicatorColor: primaryColor1,
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: [
                        Tab(
                            child: VariableText(
                          text: mainTab['tabs']![0]['title'],
                          fontcolor: tabController!.index == 0
                              ? primaryColor1
                              : primaryColorW,
                          fontsize: size.height * 0.014,
                          fontFamily: fontMedium,
                          weight: FontWeight.w600,
                        )),
                        Tab(
                            child: VariableText(
                          text: mainTab['tabs']![1]['title'],
                          fontcolor: tabController!.index == 1
                              ? primaryColor1
                              : primaryColorW,
                          fontsize: size.height * 0.014,
                          fontFamily: fontMedium,
                          weight: FontWeight.w600,
                        )),

                        Tab(
                            child: VariableText(
                          text: mainTab['tabs']![2]['title'],
                          fontcolor: tabController!.index == 2
                              ? primaryColor1
                              : primaryColorW,
                          fontsize: size.height * 0.014,
                          fontFamily: fontMedium,
                          weight: FontWeight.w600,
                        )),

                        // Tab(child: MyPopupMenu())
                      ]),
                ),
              ),
              Container(color: backgroundColor, child: MyPopupMenu())
            ],
          ),
        ));
  }
}
