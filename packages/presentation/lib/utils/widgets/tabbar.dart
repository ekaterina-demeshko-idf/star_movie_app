import 'package:flutter/material.dart';
import 'package:presentation/utils/colors.dart';
import 'package:presentation/utils/widgets/tabbarHomeScreen.dart';

class TabBarContainer extends StatelessWidget {
  const TabBarContainer({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      width: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: const Color(PrimaryColors.primaryBackgroundColor),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(PrimaryColors.primaryBorderColor),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(35),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4),
              // extract widget to widget folder
              child: TabBarHomeScreen(tabController: tabController),
            ),
          ),
        ],
      ),
    );
  }
}
