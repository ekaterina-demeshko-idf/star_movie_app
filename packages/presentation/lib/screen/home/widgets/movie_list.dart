import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/screen/home/widgets/movie_list_skelet.dart';
import 'package:presentation/utils/images/paths.dart';
import '../../../base/bloc_data.dart';
import '../../../enum/current_tab.dart';
import '../home_bloc.dart';
import '../home_data.dart';
import '../../../models/movie_model.dart';
import '../../../base/bloc_screen.dart';

class MovieListWidget extends StatefulWidget {
  final CurrentTab currentTab;

  const MovieListWidget({
    Key? key,
    required this.currentTab,
  }) : super(
          key: key,
        );

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
                ? screenData?.movieAnticipated
                : screenData?.movieTrending;

            return data.isLoading
                ? const MovieListSkelet()
                : GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: (.16 / .25),
                      crossAxisCount: 2,
                      mainAxisSpacing: 30,
                    ),
                    itemCount: screenList?.length,
                    itemBuilder: (BuildContext ctx, index) {
                      MoviePresentation? currentMovie = screenList?[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                  screenList?[index].image ?? '',
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
                              const SizedBox(
                                height: 15,
                              ),
                              RatingBar(
                                initialRating: currentMovie?.rating ?? 0,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                ignoreGestures: true,
                                itemCount: 5,
                                itemSize: 17,
                                ratingWidget: RatingWidget(
                                  full: SvgPicture.asset(ImagesPath.starFull),
                                  half: SvgPicture.asset(ImagesPath.starHalf),
                                  empty: SvgPicture.asset(ImagesPath.starEmpty),
                                ),
                                itemPadding: const EdgeInsets.only(right: 1.0),
                                onRatingUpdate: (rating) {},
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                currentMovie?.title ?? '',
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                '${currentMovie?.genre} · ${currentMovie?.runtime} | ${currentMovie?.certification}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
          } else {
            return Container();
          }
        });
  }
}
