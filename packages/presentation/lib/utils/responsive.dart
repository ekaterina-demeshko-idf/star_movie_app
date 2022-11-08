import 'package:flutter/material.dart';

class Responsive {
  const Responsive._();

  static const double smallScreen = 600;
  static const double mediumScreen = 800;
  static const double largeScreen = 1000;
  static const double extraLargeScreen = 1200;

  static bool isMediumScreen(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return deviceWidth > mediumScreen ? true : false;
  }

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
}
