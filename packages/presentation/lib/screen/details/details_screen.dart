import 'dart:ui';
import 'package:presentation/screen/details/widgets/cast_list_skelet.dart';
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
import '../../utils/dimens.dart';
import '../../utils/images/paths.dart';
import '../../utils/text_styles.dart';
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
            return DefaultTabController(
              length: 3,
              child: Scaffold(
                extendBodyBehindAppBar: true,
                backgroundColor: PrimaryColors.primaryBackgroundColor,
                appBar: AppBar(
                    backgroundColor: PrimaryColors.transparent,
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
                        height: Dimens.size260,
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
                      padding: const EdgeInsets.fromLTRB(
                        Dimens.size24,
                        Dimens.size50,
                        Dimens.size24,
                        Dimens.size16,
                      ),
                      child: SizedBox(
                        height: 1100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: Dimens.size60,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: PrimaryColors.whiteWithOpacity45,
                                        blurRadius: .1,
                                        spreadRadius: Dimens.size6,
                                      ),
                                    ]),
                                child: const Icon(
                                  Icons.play_circle_fill_rounded,
                                  color: Colors.white,
                                  shadows: [],
                                  size: Dimens.size50,
                                )),
                            const SizedBox(
                              height: Dimens.size12,
                            ),
                            Center(
                              child: Image.network(screenData?.movie?.image ??
                                  'https://www.w3schools.com/images/w3schools_green.jpg'),
                            ),
                            const SizedBox(
                              height: Dimens.size18,
                            ),
                            Text(
                              '${screenData?.movie?.title}',
                              style: AppTextStyles.headerStyle(
                                AppTextStyles.fontSize_30,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: Dimens.size10,
                            ),
                            Text(
                              '${screenData?.movie?.runtime} | ${screenData?.movie?.certification}',
                              style: AppTextStyles.descriptionStyle(
                                  AppTextStyles.fontSize_14),
                            ),
                            const SizedBox(
                              height: Dimens.size10,
                            ),
                            Text(
                              '${screenData?.movie?.genres}',
                              style: AppTextStyles.descriptionStyle(
                                  AppTextStyles.fontSize_14),
                            ),
                            const SizedBox(
                              height: Dimens.size20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${screenData?.movie?.rating.toStringAsFixed(1)}/5',
                                  style: AppTextStyles.headerStyle(
                                    AppTextStyles.fontSize_26,
                                  ),
                                ),
                                const SizedBox(
                                  width: Dimens.size10,
                                ),
                                RatingBar(
                                  initialRating: screenData?.movie?.rating ?? 0,
                                  direction: Axis.horizontal,
                                  ignoreGestures: true,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: Dimens.size30,
                                  ratingWidget: RatingWidget(
                                    full: SvgPicture.asset(ImagesPath.starFull),
                                    half: SvgPicture.asset(ImagesPath.starHalf),
                                    empty:
                                        SvgPicture.asset(ImagesPath.starEmpty),
                                  ),
                                  itemPadding: const EdgeInsets.only(
                                      right: Dimens.size2),
                                  onRatingUpdate: (rating) {},
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: Dimens.size10,
                            ),
                            Container(
                              height: Dimens.size40,
                              margin: const EdgeInsets.only(
                                top: Dimens.size10,
                                right: Dimens.size6,
                                left: Dimens.size6,
                                bottom: Dimens.size24,
                              ),
                              padding: const EdgeInsets.all(Dimens.size4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: PrimaryColors.primaryBorderColor,
                                  width: Dimens.size2,
                                ),
                                borderRadius:
                                    BorderRadius.circular(Dimens.size34),
                              ),
                              child: TabBar(
                                unselectedLabelColor:
                                    PrimaryColors.whiteWithOpacity80,
                                labelColor: Colors.white,
                                indicatorColor:
                                    PrimaryColors.whiteWithOpacity80,
                                indicator: BoxDecoration(
                                  color: PrimaryColors.primaryColor,
                                  borderRadius:
                                      BorderRadius.circular(Dimens.size24),
                                ),
                                tabs: const [
                                  Tab(
                                    text: 'Details',
                                  ),
                                  Tab(
                                    text: 'Reviews',
                                  ),
                                  Tab(
                                    text: 'Showtime',
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: Dimens.size16,
                            ),
                            Text(
                              'Synopsis',
                              textAlign: TextAlign.left,
                              style: AppTextStyles.headerStyle(
                                  AppTextStyles.fontSize_20),
                            ),
                            const SizedBox(
                              height: Dimens.size10,
                            ),
                            ReadMoreText(
                              '${screenData?.movie?.overview}',
                              trimLines: 4,
                              trimMode: TrimMode.Line,
                              colorClickableText: PrimaryColors.primaryLink,
                              trimCollapsedText: 'Show more',
                              trimExpandedText: 'Show less',
                              style: AppTextStyles.descriptionStyle(
                                  AppTextStyles.fontSize_14,
                                  lineHeight: Dimens.size20),
                            ),
                            const SizedBox(
                              height: Dimens.size20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Cast & Crew',
                                  textAlign: TextAlign.left,
                                  style: AppTextStyles.headerStyle(
                                      AppTextStyles.fontSize_20),
                                ),
                                Text(
                                  'View All',
                                  style: AppTextStyles.headerStyle(
                                    AppTextStyles.fontSize_18,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: data.isLoading
                                  ? const CastListSkelet()
                                  : CastList(screenData: screenData),
                            )
                          ],
                        ),
                      ),
                    )
                  ]),
                ),
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

class CastList extends StatelessWidget {
  const CastList({
    Key? key,
    required this.screenData,
  }) : super(key: key);

  final DetailsData? screenData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount:
            (screenData?.cast?.length ?? 0) < 4 ? screenData?.cast?.length : 4,
        shrinkWrap: true,
        padding: const EdgeInsets.all(Dimens.size6),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(Dimens.size4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: Dimens.size50,
                  width: Dimens.size50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimens.size24),
                    child: Image.network(
                      '${screenData?.cast?[index].image}',
                      fit: BoxFit.fitWidth,
                      errorBuilder: (context, exception, stackTrace) =>
                          Container(
                        height: Dimens.size50,
                        width: Dimens.size50,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: Dimens.size10,
                ),
                Text(
                  '${screenData?.cast?[index].name}',
                  style: AppTextStyles.headerStyle(
                    AppTextStyles.fontSize_14,
                  ),
                ),
                const SizedBox(
                  width: Dimens.size16,
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      ' ··· ',
                      style: AppTextStyles.descriptionStyle(
                          AppTextStyles.fontSize_20),
                    )),
                const SizedBox(
                  width: Dimens.size6,
                ),
                Expanded(
                    child: Text(
                  '${screenData?.cast?[index].character?.toUpperCase()}',
                  style:
                      AppTextStyles.descriptionStyle(AppTextStyles.fontSize_14),
                  maxLines: 1,
                ))
              ],
            ),
          );
        });
  }
}
