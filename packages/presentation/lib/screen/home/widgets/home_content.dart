import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../enum/current_tab.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimens.dart';
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
                  height: Dimens.size40,
                  margin: const EdgeInsets.only(
                    top: Dimens.size10,
                    right: Dimens.size18,
                    left: Dimens.size18,
                    bottom: Dimens.size24,
                  ),
                  padding: const EdgeInsets.all(Dimens.size4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: PrimaryColors.primaryBorderColor,
                      width: Dimens.size2,
                    ),
                    borderRadius: BorderRadius.circular(Dimens.size36),
                  ),
                  child: TabBar(
                    unselectedLabelColor: PrimaryColors.whiteWithOpacity80,
                    labelColor: PrimaryColors.white,
                    indicatorColor: PrimaryColors.whiteWithOpacity80,
                    indicator: BoxDecoration(
                      color: PrimaryColors.primaryColor,
                      borderRadius: BorderRadius.circular(Dimens.size26),
                    ),
                    tabs: [
                      Tab(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.play_circle_fill_rounded),
                            const SizedBox(width: Dimens.size8),
                            Text(AppLocalizations.of(context)!.nowShowing),
                          ],
                        ),
                      ),
                      Tab(
                        text: AppLocalizations.of(context)!.comingSoon,
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
