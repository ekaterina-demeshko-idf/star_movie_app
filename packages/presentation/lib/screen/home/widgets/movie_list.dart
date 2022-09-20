import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/utils/images/paths.dart';

import '../../../enum/current_tab.dart';

class MovieListWidget extends StatefulWidget {
  final movieList;
  final currentTab;
  final bloc;

  const MovieListWidget({
    Key? key,
    required this.movieList,
    required this.currentTab,
    required this.bloc,
  }) : super(
          key: key,
        );

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.currentTab == CurrentTab.anticipated &&
        widget.movieList.length == 0) {
      widget.bloc.getAnticipatedData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: (.16 / .25),
        crossAxisCount: 2,
        mainAxisSpacing: 30,
      ),
      itemCount: widget.movieList?.length,
      itemBuilder: (BuildContext ctx, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GestureDetector(
            onTap: () {
              widget.bloc.openDetailsPage(widget.movieList[index]);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.network(
                    widget.movieList[index].image,
                    errorBuilder: (context, exception, stackTrace) {
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
                  initialRating: widget.movieList[index].rating,
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
                  widget.movieList[index].title,
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
                  '${widget.movieList[index].genre} · ${widget.movieList[index].runtime} | ${widget.movieList[index].certification}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
