import 'package:flutter/material.dart';
import 'package:playeon/widgets/common.dart';

import 'dashboard/home_screen.dart';
import 'dashboard/profile.dart';
import 'dashboard/searchscreen.dart';
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
      {"title": "Seach"},
      {"title": "Home"},
      {"title": "Profile"}
    ],
  };

  @override
  void initState() {
    super.initState();
    tabController = TabController(
        length: 3,
        animationDuration: const Duration(milliseconds: 200),
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          searchscreen(),
          HomeScreen(),
          Profile(),
        ],
      ),
      bottomNavigationBar: Container(
        height: size.height * 0.085,
        decoration: BoxDecoration(color: primaryColorW),
        child: TabBar(
          controller: tabController,
          indicatorColor: primaryColor1,
          indicator: const BoxDecoration(
              border: Border(top: BorderSide(color: textColor1, width: 2))),
          tabs: List.generate(mainTab['tabs']!.length, (index) {
            return Tab(
                child: VariableText(
              text: mainTab['tabs']![index]['title'],
              fontcolor:
                  tabController!.index == index ? primaryColor1 : primaryColorB,
              fontsize: size.width * 0.025,
              fontFamily: fontRegular,
              weight: FontWeight.w500,
            ));
          }),
        ),
      ),
    );
  }
}
