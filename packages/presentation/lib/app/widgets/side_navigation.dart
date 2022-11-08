import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:presentation/app/app_bloc.dart';
import 'package:presentation/app/widgets/item.dart';
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
          RailItem(
            imagePath: ImagesPath.movieIcon,
            label: l10n.title,
          ),
          RailItem(
            imagePath: ImagesPath.tickerIcon,
            label: l10n.showtime,
          ),
          RailItem(
            imagePath: ImagesPath.alarmIcon,
            label: l10n.notifications,
          ),
          RailItem(
            imagePath: ImagesPath.personIcon,
            label: l10n.titleProfile,
          ),
        ],
      ),
    );
  }
}
