import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/utils/colors.dart';

class Item {
  Item._();

  static BottomNavigationBarItem getBottomItem(
    String imagePath,
    String label,
  ) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        imagePath,
        color: PrimaryColors.whiteWithOpacity80,
      ),
      activeIcon: SvgPicture.asset(
        imagePath,
        color: PrimaryColors.primarySelected,
      ),
      label: label,
    );
  }

  static NavigationRailDestination getRailItem(
    String imagePath,
    String label,
  ) {
    return NavigationRailDestination(
      icon: SvgPicture.asset(
        imagePath,
        color: PrimaryColors.whiteWithOpacity80,
      ),
      selectedIcon: SvgPicture.asset(
        imagePath,
        color: PrimaryColors.primarySelected,
      ),
      label: Text(label),
    );
  }
}
