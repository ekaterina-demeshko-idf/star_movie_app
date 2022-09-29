import 'package:flutter/material.dart';
import 'package:presentation/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/dimens.dart';

class MovieListSkelet extends StatelessWidget {
  const MovieListSkelet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: PrimaryColors.shimmer,
      highlightColor: PrimaryColors.whiteWithOpacity45,
      enabled: true,
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: (.16 / .25),
          crossAxisCount: 2,
          mainAxisSpacing: Dimens.size30,
        ),
        itemCount: 6,
        itemBuilder: (BuildContext ctx, index) {
          return Padding(
            padding: const EdgeInsets.all(Dimens.size6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    width: Dimens.size200,
                    height: Dimens.size400,
                    color: PrimaryColors.whiteWithOpacity45,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Icon(
                      Icons.star_border,
                      color: PrimaryColors.ratingYellow,
                    ),
                    Icon(
                      Icons.star_border,
                      color: PrimaryColors.ratingYellow,
                    ),
                    Icon(
                      Icons.star_border,
                      color: PrimaryColors.ratingYellow,
                    ),
                    Icon(
                      Icons.star_border,
                      color: PrimaryColors.ratingYellow,
                    ),
                    Icon(
                      Icons.star_border,
                      color: PrimaryColors.ratingYellow,
                    ),
                  ],
                ),
                Container(
                  height: Dimens.size18,
                  color: PrimaryColors.white,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: Dimens.size8,
                      width: Dimens.size24,
                      color: PrimaryColors.white,
                    ),
                    const Icon(
                      Icons.circle,
                      size: Dimens.size6,
                      color: PrimaryColors.whiteWithOpacity45,
                    ),
                    Container(
                      height: Dimens.size8,
                      width: Dimens.size44,
                      color: PrimaryColors.white,
                    ),
                    const SizedBox(
                      width: Dimens.size10,
                    ),
                    Container(
                      height: Dimens.size8,
                      width: Dimens.size24,
                      color: PrimaryColors.white,
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
