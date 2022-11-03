import 'package:flutter/material.dart';
import 'package:presentation/utils/text_styles.dart';

import 'dimens.dart';

class Responsive {
  const Responsive._();

  static int getCrossAxisCount(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final targetPlatform = Theme.of(context).platform;
    if (screenWidth > 1200) {
      return 6;
    } else if (screenWidth > 1000) {
      return 5;
    } else if (screenWidth > 800) {
      return 4;
    } else if (screenWidth > 600) {
      return 3;
    } else {
      return 2;
    }
  }

  static int getExpandedFlex(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 800) {
      return 1;
    } else {
      return 0;
    }
  }

  static Axis getAxisOfDetails(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 800) {
      return Axis.horizontal;
    } else {
      return Axis.vertical;
    }
  }

  static double backgroundDetailsImage(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 800) {
      return Dimens.size400;
    } else {
      return Dimens.size260;
    }
  }

  static double posterDetailsImage(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 800) {
      return .6;
    } else {
      return 1;
    }
  }
  static double textDetailsImage(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 800) {
      return AppTextStyles.fontSize_18;
    } else {
      return AppTextStyles.fontSize_14;
    }
  }

  static double getLoginFormWidth(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 800) {
      return Dimens.size500;
    } else if (screenWidth > 400) {
      return Dimens.size360;
    } else {
      return Dimens.size300;
    }
  }

  static double getLoginButtonWidth(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 800) {
      return Dimens.size220;
    } else if (screenWidth > 400) {
      return Dimens.size145;
    } else {
      return Dimens.size120;
    }
  }

  static bool switchToSideBar(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 800) {
      return true;
    }
    return false;
  }
}
