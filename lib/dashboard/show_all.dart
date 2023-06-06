// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:flutter/material.dart';
import '../models/movies_model.dart';
import '../widgets/common.dart';
import '../widgets/style.dart';
import 'Introduction.dart';

class ShowAllMovies extends StatefulWidget {
  List<MoviesModel> showList;
  String? title;
  ShowAllMovies({Key? key, required this.showList, this.title})
      : super(key: key);

  @override
  State<ShowAllMovies> createState() => _ShowAllMoviesState();
}

class _ShowAllMoviesState extends State<ShowAllMovies> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 15),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
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
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  VariableText(
                    text: widget.title,
                    fontcolor: primaryColorW,
                    fontsize: size.height * 0.02,
                    fontFamily: fontMedium,
                    weight: FontWeight.w500,
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Expanded(
                child: Container(
                  width: size.width,
                  height: size.height * 0.6,
                  padding: EdgeInsets.symmetric(
                      vertical: size.height * verticalPadding),
                  child: Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                            itemCount: widget.showList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 0.5),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const ScrollPhysics(),
                            itemBuilder: (_, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      SwipeLeftAnimationRoute(
                                          milliseconds: 200,
                                          widget: IntroductionPage(
                                              image: widget.showList[index].imgLgPoster)));
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height: size.height * 0.38,
                                      width: size.height * .23,
                                      child: Image.network(
                                        widget.showList[index].imgSmPoster!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    VariableText(
                                      text:widget.showList[index].title,
                                      fontcolor: primaryColorW,
                                      fontsize: size.height * 0.02,
                                      fontFamily: fontMedium,
                                      weight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
