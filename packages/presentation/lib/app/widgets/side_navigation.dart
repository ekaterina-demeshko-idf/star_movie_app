import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:presentation/app/app_bloc.dart';
import 'package:presentation/utils/colors.dart';
import 'package:presentation/utils/dimens.dart';
import 'package:presentation/utils/images/paths.dart';

class SideNavigation extends StatelessWidget {
  const SideNavigation({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  final AppBloc bloc;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.only(bottom: Dimens.size14),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            width: Dimens.size05,
            color: PrimaryColors.primaryUnselected,
          ),
        ),
      ),
      child: NavigationRail(
        backgroundColor: PrimaryColors.primaryBackgroundColor,
        selectedIndex: bloc.selectedIndex,
        onDestinationSelected: (index) {
          bloc.onItemTapped(index);
        },
        labelType: NavigationRailLabelType.none,
        destinations: <NavigationRailDestination>[
          NavigationRailDestination(
            icon: SvgPicture.asset(
              ImagesPath.movieIcon,
              color: PrimaryColors.whiteWithOpacity80,
            ),
            selectedIcon: SvgPicture.asset(
              ImagesPath.movieIcon,
              color: PrimaryColors.primarySelected,
            ),
            label: Text(l10n.title),
          ),
          NavigationRailDestination(
            icon: SvgPicture.asset(
              ImagesPath.tickerIcon,
              color: PrimaryColors.whiteWithOpacity80,
            ),
            selectedIcon: SvgPicture.asset(
              ImagesPath.tickerIcon,
              color: PrimaryColors.primarySelected,
            ),
            label: Text(l10n.showtime),
          ),
          NavigationRailDestination(
            icon: SvgPicture.asset(
              ImagesPath.alarmIcon,
              color: PrimaryColors.whiteWithOpacity80,
            ),
            selectedIcon: SvgPicture.asset(
              ImagesPath.alarmIcon,
              color: PrimaryColors.primarySelected,
            ),
            label: Text(l10n.notifications),
          ),
          NavigationRailDestination(
            icon: SvgPicture.asset(
              ImagesPath.personIcon,
              color: PrimaryColors.whiteWithOpacity80,
            ),
            selectedIcon: SvgPicture.asset(
              ImagesPath.personIcon,
              color: PrimaryColors.primarySelected,
            ),
            label: Text(l10n.titleProfile),
          ),
        ],
      ),
    );
  }
}
