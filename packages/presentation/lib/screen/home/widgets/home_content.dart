import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import 'movie_list.dart';
import 'movie_list_skelet.dart';

class HomeContent extends StatelessWidget {
  final bloc;
  final screenData;
  final bool isLoading;

  const HomeContent({
    Key? key,
    required this.screenData,
    required this.bloc,
    required this.isLoading,

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
                Expanded(
                  child: TabBarView(
                    children: [
                      isLoading
                          ? const MovieListSkelet()
                          : MovieListWidget(
                              screenData: screenData.movieTrending,
                              bloc: bloc,
                            ),
                      isLoading
                          ? const MovieListSkelet()
                          : MovieListWidget(
                              screenData: screenData.movieAnticipated,
                              bloc: bloc,
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
