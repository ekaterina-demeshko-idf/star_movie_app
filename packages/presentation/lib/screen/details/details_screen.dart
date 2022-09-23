import 'dart:ui';
import 'package:readmore/readmore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/models/movie_model.dart';
import '../../base/bloc_data.dart';
import '../../base/bloc_screen.dart';
import '../../navigation/base_arguments.dart';
import '../../navigation/base_page.dart';
import '../../utils/colors.dart';
import '../../utils/images/paths.dart';
import 'details_bloc.dart';
import 'details_data.dart';

class DetailsScreenArguments extends BaseArguments {
  final MoviePresentation movie;

  DetailsScreenArguments({
    required this.movie,
    Function(dynamic value)? result,
  }) : super(result: result);
}

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  static const _routeName = '/DetailsPage';

  static BasePage page(DetailsScreenArguments arguments) => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (context) => const DetailsScreen(),
        arguments: arguments,
        hideNavBar: false,
      );

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends BlocScreenState<DetailsScreen, DetailsBloc> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BlocData<DetailsData?>>(
        stream: bloc.dataStream,
        builder: (context, snapshot) {
          final data = snapshot.data;
          final screenData = data?.data;
          if (data != null) {
            //print('${screenData?.cast?[1].image}');
            return Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor:
                  const Color(PrimaryColors.primaryBackgroundColor),
              //PrimaryColors.primaryBackgroundColor
              appBar: AppBar(
                  backgroundColor: const Color(0x00000000),
                  elevation: 0,
                  actions: [
                    IconButton(
                      onPressed: () => {},
                      icon: SvgPicture.asset(ImagesPath.shareIcon),
                      color: Colors.white,
                    ),
                  ]),
              body: SingleChildScrollView(
                child: Stack(children: [
                  ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaY: 3, sigmaX: 3),
                    child: Container(
                      height: 262,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(screenData?.movie?.image ??
                              'https://www.w3schools.com/images/w3schools_green.jpg'),
                          fit: BoxFit.fitWidth,
                          alignment: FractionalOffset.topCenter,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 50.0, 25, 15),
                    child: SizedBox(
                      height: 1000, // todo remove hardcoded value
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 60,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(
                                          PrimaryColors.whiteWithOpacity45),
                                      blurRadius: .1,
                                      spreadRadius: 5,
                                    ),
                                  ]),
                              child: const Icon(
                                Icons.play_circle_fill_rounded,
                                color: Colors.white,
                                shadows: [],
                                size: 50,
                              )),
                          SizedBox(
                            height: 12,
                          ),
                          Center(
                            child: Image.network(screenData?.movie?.image ??
                                'https://www.w3schools.com/images/w3schools_green.jpg'),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Text(
                            '${screenData?.movie?.title}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 30),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${screenData?.movie?.runtime} | ${screenData?.movie?.certification}',
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${screenData?.movie?.genres}',
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${screenData?.movie?.rating.toStringAsFixed(1)}/5',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 27,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              RatingBar(
                                initialRating: screenData?.movie?.rating ?? 0,
                                direction: Axis.horizontal,
                                ignoreGestures: true,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 30,
                                ratingWidget: RatingWidget(
                                  full: SvgPicture.asset(ImagesPath.starFull),
                                  half: SvgPicture.asset(ImagesPath.starHalf),
                                  empty: SvgPicture.asset(ImagesPath.starEmpty),
                                ),
                                itemPadding: const EdgeInsets.only(right: 1.0),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                15,
                              ),
                              border: Border.all(
                                width: 3,
                                color: Colors.red,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                  width: 150,
                                  height: 15,
                                  child: Container(
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            ),
                          ), // todo make tabbar or some switcher
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Synopsis',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ReadMoreText(
                            '${screenData?.movie?.overview}',
                            trimLines: 4,
                            trimMode: TrimMode.Line,
                            colorClickableText: Colors.blue,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: 'Show less',
                            style: TextStyle(
                              color: Color(PrimaryColors.whiteWithOpacity70),
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Cast & Crew',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                ),
                              ),
                              Text(
                                'View All',
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 18),
                              )
                            ],
                          ),
                          Expanded(
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 4,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          child: Image.network(
                                            '${screenData?.cast?[index].image}',
                                            fit: BoxFit.fitWidth,
                                            errorBuilder: (context, exception,
                                                    stackTrace) =>
                                                Container(
                                              height: 50,
                                              width: 50,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '${screenData?.cast?[index].name}',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.menu,
                                        color: Colors.grey,
                                      ),
                                      Expanded(
                                          child: Text(
                                        '${screenData?.cast?[index].character?.toUpperCase()}',
                                        style: TextStyle(color: Colors.grey),
                                        maxLines: 1,
                                      ))
                                    ],
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
                  )
                ]),
              ),
            );
          } else {
            return Scaffold(
              body: Container(),
            );
          }
        });
  }
}
