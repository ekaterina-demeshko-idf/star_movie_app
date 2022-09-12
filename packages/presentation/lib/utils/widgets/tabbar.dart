import 'package:flutter/material.dart';
import 'package:presentation/utils/colors.dart';

class TabBarContainer extends StatelessWidget {
  const TabBarContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(
        top: 10,
        right: 18,
        left: 18,
        bottom: 24,
      ),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(PrimaryColors.primaryBorderColor),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(35),
      ),
      child: TabBar(
        unselectedLabelColor: const Color(PrimaryColors.whiteWithOpacity),
        labelColor: Colors.white,
        indicatorColor: const Color(PrimaryColors.whiteWithOpacity),
        indicator: BoxDecoration(
          color: const Color(PrimaryColors.primaryColor),
          borderRadius: BorderRadius.circular(25),
        ),
        tabs: [
          Tab(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.play_circle_fill_rounded),
                SizedBox(width: 8),
                Text('Now Showing'),
              ],
            ),
          ),
          const Tab(
            text: 'Coming Soon',
          ),
        ],
      ),
    );
  }
}
