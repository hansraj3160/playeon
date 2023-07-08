// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/movies_model.dart';
import '../widgets/common.dart';
import '../widgets/style.dart';
import 'introduction.dart';
import 'about.dart';

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
          padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
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
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * verticalPadding,
                  ),
                  child: GridView.builder(
                      itemCount: widget.showList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: size.width * 0.03,
                        mainAxisSpacing: size.height * 0.01,
                        // childAspectRatio: 0.63,
                        childAspectRatio: size.width / (size.height * 0.95),
                      ),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (_, index) {
                        String title = widget.showList[index].title!;
                        String setName = title.substring(0, 1).toUpperCase() +
                            title.substring(1).toLowerCase();
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                SwipeLeftAnimationRoute(
                                    milliseconds: 200,
                                    widget: About(
                                      movieData: widget.showList[index],
                                    )));
                          },
                          child: Column(
                            children: [
                              Container(
                                  height: size.height * 0.14,
                                  width: size.width * 0.3,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          widget.showList[index].imgSmPoster!,
                                      placeholder: (context, url) => SizedBox(
                                        height: 1,
                                        width: 1,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 1,
                                          value: 1,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  )),
                              Row(
                                children: [
                                  Expanded(
                                    child: VariableText(
                                      text: setName,
                                      fontcolor: primaryColorW,
                                      fontsize: size.height * 0.018,
                                      fontFamily: fontMedium,
                                      textAlign: TextAlign.center,
                                      max_lines: 2,
                                      weight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
