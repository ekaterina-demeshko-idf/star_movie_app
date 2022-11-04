import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/base/bloc_data.dart';
import 'package:presentation/base/bloc_screen.dart';
import 'package:presentation/models/movie_model.dart';
import 'package:presentation/navigation/base_arguments.dart';
import 'package:presentation/navigation/base_page.dart';
import 'package:presentation/screen/details/details_bloc.dart';
import 'package:presentation/screen/details/details_data.dart';
import 'package:presentation/screen/details/widgets/cast_list_skelet.dart';
import 'package:presentation/utils/colors.dart';
import 'package:presentation/utils/dimens.dart';
import 'package:presentation/utils/images/paths.dart';
import 'package:presentation/utils/responsive.dart';
import 'package:presentation/utils/text_styles.dart';
import 'package:readmore/readmore.dart';

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
          final l10n = AppLocalizations.of(context)!;
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
                        onPressed: () => bloc.onShareButtonPressed(
                          l10n.share(screenData?.movie?.traktId ?? 0),
                        ),
                        icon: SvgPicture.asset(ImagesPath.shareIcon),
                        color: PrimaryColors.white,
                      ),
                    ]),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          ImageFiltered(
                            imageFilter: ImageFilter.blur(
                              sigmaY: 3,
                              sigmaX: 3,
                            ),
                            child: Container(
                              height:
                                  Responsive.backgroundDetailsImage(context),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    '${screenData?.movie?.image}',
                                  ),
                                  fit: BoxFit.fitWidth,
                                  alignment: FractionalOffset.topCenter,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: Dimens.size100,
                              ),
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
                                  color: PrimaryColors.white,
                                  shadows: [],
                                  size: Dimens.size50,
                                ),
                              ),
                              const SizedBox(height: Dimens.size12),
                              Center(
                                child: Image.network(
                                  '${screenData?.movie?.image}',
                                  scale: Responsive.posterDetailsImage(context),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: Dimens.size18),
                      Text(
                        '${screenData?.movie?.title}',
                        style: AppTextStyles.headerStyle(
                          AppTextStyles.fontSize_30,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: Dimens.size10),
                      Text(
                        '${screenData?.movie?.runtime} | ${screenData?.movie?.certification}',
                        style: AppTextStyles.descriptionStyle(
                          Responsive.textDetailsImage(context),
                        ),
                      ),
                      const SizedBox(height: Dimens.size10),
                      Text(
                        '${screenData?.movie?.genres}',
                        style: AppTextStyles.descriptionStyle(
                          Responsive.textDetailsImage(context),
                        ),
                      ),
                      const SizedBox(height: Dimens.size20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${screenData?.movie?.rating.toStringAsFixed(1)}/5',
                            style: AppTextStyles.headerStyle(
                              AppTextStyles.fontSize_26,
                            ),
                          ),
                          const SizedBox(width: Dimens.size10),
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
                              empty: SvgPicture.asset(ImagesPath.starEmpty),
                            ),
                            itemPadding:
                                const EdgeInsets.only(right: Dimens.size2),
                            onRatingUpdate: (rating) {},
                          ),
                        ],
                      ),
                      const SizedBox(height: Dimens.size10),
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
                          borderRadius: BorderRadius.circular(Dimens.size34),
                        ),
                        child: TabBar(
                          unselectedLabelColor:
                              PrimaryColors.whiteWithOpacity80,
                          labelColor: PrimaryColors.white,
                          indicatorColor: PrimaryColors.whiteWithOpacity80,
                          indicator: BoxDecoration(
                            color: PrimaryColors.primaryColor,
                            borderRadius: BorderRadius.circular(Dimens.size24),
                          ),
                          tabs: [
                            Tab(text: l10n.details),
                            Tab(text: l10n.reviews),
                            Tab(text: l10n.showtime),
                          ],
                        ),
                      ),
                      Flex(
                        direction: Responsive.getAxisOfDetails(context),
                        children: [
                          Expanded(
                            flex: Responsive.getExpandedFlex(context),
                            child: Padding(
                              padding: const EdgeInsets.all(Dimens.size24),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    l10n.synopsis,
                                    textAlign: TextAlign.left,
                                    style: AppTextStyles.headerStyle(
                                        AppTextStyles.fontSize_20),
                                  ),
                                  const SizedBox(height: Dimens.size10),
                                  ReadMoreText(
                                    '${screenData?.movie?.overview}',
                                    trimLines: 4,
                                    trimMode: TrimMode.Line,
                                    colorClickableText:
                                        PrimaryColors.primaryLink,
                                    trimCollapsedText: l10n.showMore,
                                    trimExpandedText: l10n.showLess,
                                    style: AppTextStyles.descriptionStyle(
                                      Responsive.textDetailsImage(context),
                                      lineHeight: Dimens.size20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: Responsive.getExpandedFlex(context),
                            child: Padding(
                              padding: const EdgeInsets.all(Dimens.size24),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        l10n.castCrew,
                                        textAlign: TextAlign.left,
                                        style: AppTextStyles.headerStyle(
                                          AppTextStyles.fontSize_20,
                                        ),
                                      ),
                                      Text(
                                        l10n.viewAll,
                                        style: AppTextStyles.linkStyle(
                                          AppTextStyles.fontSize_18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  data.isLoading
                                      ? const CastListSkelet()
                                      : CastList(screenData: screenData),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
                SizedBox(
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
                        color: PrimaryColors.whiteWithOpacity45,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: Dimens.size10),
                Text(
                  '${screenData?.cast?[index].name}',
                  style: AppTextStyles.headerStyle(
                    AppTextStyles.fontSize_14,
                  ),
                ),
                const SizedBox(width: Dimens.size16),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      ' ··· ',
                      style: AppTextStyles.descriptionStyle(
                        AppTextStyles.fontSize_20,
                      ),
                    )),
                const SizedBox(width: Dimens.size6),
                Expanded(
                  child: Text(
                    '${screenData?.cast?[index].character?.toUpperCase()}',
                    style: AppTextStyles.descriptionStyle(
                      AppTextStyles.fontSize_14,
                    ),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
