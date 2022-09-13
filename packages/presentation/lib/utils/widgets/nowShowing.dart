import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../images/paths.dart';

class NowShowing extends StatelessWidget {
  const NowShowing({
    Key? key,
    required this.screenData,
  }) : super(
          key: key,
        );

  final screenData;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: (.16 / .25),
        crossAxisCount: 2,
        mainAxisSpacing: 30,
      ),
      itemCount: screenData?.movieTrending.length,
      itemBuilder: (BuildContext ctx, index) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.network(
                  screenData?.movieTrending[index].image,
                  errorBuilder: (context, exception, stackTrace) {
                    return Image.asset(ImagesPath.notFound,);
                  },
                  fit: BoxFit.contain,
                ),
              ),
              RatingBar(
                initialRating: screenData?.movieTrending[index].rating,
                direction: Axis.horizontal,
                allowHalfRating: true,
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
              Text(
                screenData?.movieTrending[index].title ?? 'fa',
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Text(
                '${screenData?.movieTrending[index].genre} · ${screenData?.movieTrending[index].runtime} | ${screenData?.movieTrending[index].certification}',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        );
      },
    );
  }
}
