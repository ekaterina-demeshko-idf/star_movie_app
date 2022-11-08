import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/utils/colors.dart';

class BottomItem extends BottomNavigationBarItem {
  BottomItem({
    required String imagePath,
    required String label,
  }) : super(
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

class RailItem extends NavigationRailDestination {
  RailItem({
    required String imagePath,
    required String label,
  }) : super(
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
