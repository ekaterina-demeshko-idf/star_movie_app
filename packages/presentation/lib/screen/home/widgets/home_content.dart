import 'package:flutter/material.dart';
import '../../../enum/current_tab.dart';
import '../../../utils/colors.dart';
import 'movie_list.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTabController(
          length: 2,
          child: Expanded(
            child: Column(
              children: <Widget>[
                Container(
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
                    unselectedLabelColor:
                        const Color(PrimaryColors.whiteWithOpacity),
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
                ),
                const Expanded(
                  child: TabBarView(
                    children: [
                      MovieListWidget(
                        currentTab: CurrentTab.trending,
                      ),
                      MovieListWidget(
                        currentTab: CurrentTab.anticipated,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
