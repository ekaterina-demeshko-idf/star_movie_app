import 'package:flutter/material.dart';
import 'package:presentation/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/dimens.dart';
import '../../../utils/text_styles.dart';

class CastListSkelet extends StatelessWidget {
  const CastListSkelet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: PrimaryColors.shimmer,
      highlightColor: PrimaryColors.whiteWithOpacity45,
      enabled: true,
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          shrinkWrap: true,
          padding: const EdgeInsets.all(Dimens.size4),
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
                      child: Container(
                        height: Dimens.size50,
                        width: Dimens.size50,
                        color: PrimaryColors.whiteWithOpacity45,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: Dimens.size10,
                  ),
                  Container(
                    height: Dimens.size12,
                    width: Dimens.size50,
                    color: PrimaryColors.whiteWithOpacity45,
                  ),
                  const SizedBox(
                    width: Dimens.size16,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        ' ··· ',
                        style: AppTextStyles.descriptionStyle(
                          AppTextStyles.fontSize_20,
                        ),
                      )),
                  const SizedBox(
                    width: Dimens.size4,
                  ),
                  Expanded(
                    child: Container(
                      height: Dimens.size12,
                      width: Dimens.size50,
                      color: PrimaryColors.whiteWithOpacity45,
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
