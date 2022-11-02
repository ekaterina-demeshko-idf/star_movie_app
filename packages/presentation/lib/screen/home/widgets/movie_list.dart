import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:presentation/screen/home/widgets/movie_list_skelet.dart';
import 'package:presentation/utils/images/paths.dart';
import 'package:presentation/utils/responsive.dart';
import '../../../base/bloc_data.dart';
import '../../../enum/current_tab.dart';
import '../../../utils/dimens.dart';
import '../../../utils/text_styles.dart';
import '../home_bloc.dart';
import '../home_data.dart';
import '../../../models/movie_model.dart';
import '../../../base/bloc_screen.dart';

class MovieListWidget extends StatefulWidget {
  final CurrentTab currentTab;

  const MovieListWidget({
    required this.currentTab,
    super.key,
  });

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends BlocScreenState<MovieListWidget, HomeBloc> {
  @override
  void initState() {
    super.initState();
    bloc.getMovieData(widget.currentTab);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BlocData<HomeData?>>(
        stream: bloc.dataStream,
        builder: (context, snapshot) {
          final data = snapshot.data;
          final screenData = data?.data;
          if (data != null) {
            final screenList = widget.currentTab == CurrentTab.anticipated
                ? screenData?.movieAnticipated ?? []
                : screenData?.movieTrending ?? [];
            final bool noData = screenList.isEmpty;
            return data.isLoading
                ? const MovieListSkelet()
                : (noData
                    ? Center(
                        child: Text(
                          AppLocalizations.of(context)!.noData,
                          style: AppTextStyles.headerStyle(14),
                        ),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: (.16 / .25),
                          crossAxisCount: Responsive.getCrossAxisCount(context),
                          mainAxisSpacing: Dimens.size30,
                        ),
                        itemCount: screenList.length,
                        itemBuilder: (BuildContext ctx, index) {
                          MoviePresentation? currentMovie = screenList[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimens.size20),
                            child: GestureDetector(
                              onTap: () {
                                if (currentMovie != null) {
                                  bloc.openDetailsPage(currentMovie);
                                }
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      screenList[index].image,
                                      errorBuilder:
                                          (context, exception, stackTrace) {
                                        return Image.asset(
                                          ImagesPath.notFound,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: Dimens.size16),
                                  RatingBar(
                                    initialRating: currentMovie.rating,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    ignoreGestures: true,
                                    itemCount: 5,
                                    itemSize: Dimens.size16,
                                    ratingWidget: RatingWidget(
                                      full:
                                          SvgPicture.asset(ImagesPath.starFull),
                                      half:
                                          SvgPicture.asset(ImagesPath.starHalf),
                                      empty: SvgPicture.asset(
                                          ImagesPath.starEmpty),
                                    ),
                                    itemPadding: const EdgeInsets.only(
                                        right: Dimens.size2),
                                    onRatingUpdate: (rating) {},
                                  ),
                                  const SizedBox(height: Dimens.size8),
                                  Text(
                                    currentMovie.title,
                                    textAlign: TextAlign.start,
                                    style: AppTextStyles.headerStyle(
                                      AppTextStyles.fontSize_16,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: Dimens.size4),
                                  Text(
                                    '${currentMovie.genre} · ${currentMovie.runtime} | ${currentMovie.certification}',
                                    style: AppTextStyles.descriptionStyle(
                                      AppTextStyles.fontSize_14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ));
          } else {
            return Container();
          }
        });
  }
}
