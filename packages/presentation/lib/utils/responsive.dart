import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:presentation/utils/text_styles.dart';
import 'dimens.dart';

class Responsive {
  const Responsive._();

  static const double largeMobileScreen = 400;
  static const double smallScreen = 600;
  static const double mediumScreen = 800;
  static const double largeScreen = 1000;
  static const double extraLargeScreen = 1200;

  static int getCrossAxisCount(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > extraLargeScreen) {
      return 6;
    } else if (screenWidth > largeScreen) {
      return 5;
    } else if (screenWidth > mediumScreen) {
      return 4;
    } else if (screenWidth > smallScreen) {
      return 3;
    } else {
      return 2;
    }
  }

  static int getExpandedFlex(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > mediumScreen) {
      return 1;
    } else {
      return 0;
    }
  }

  static Axis getAxisOfDetails(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > mediumScreen) {
      return Axis.horizontal;
    } else {
      return Axis.vertical;
    }
  }

  static double backgroundDetailsImage(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > mediumScreen) {
      return Dimens.size400;
    } else {
      return Dimens.size260;
    }
  }

  static double posterDetailsImage(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > mediumScreen) {
      return .6;
    } else {
      return 1;
    }
  }

  static double textDetailsImage(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > mediumScreen) {
      return AppTextStyles.fontSize_18;
    } else {
      return AppTextStyles.fontSize_14;
    }
  }

  static double getLoginFormWidth(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > mediumScreen) {
      return Dimens.size500;
    } else if (screenWidth > largeMobileScreen) {
      return Dimens.size360;
    } else {
      return Dimens.size300;
    }
  }

  static double getLoginButtonWidth(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > mediumScreen) {
      return Dimens.size220;
    } else if (screenWidth > largeMobileScreen) {
      return Dimens.size145;
    } else {
      return Dimens.size120;
    }
  }

  static bool switchToSideBar(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > mediumScreen && Platform.isMacOS) {
      return true;
    }
    return false;
  }
}
