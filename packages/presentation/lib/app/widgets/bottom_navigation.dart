import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:presentation/app/app_bloc.dart';
import 'package:presentation/utils/colors.dart';
import 'package:presentation/utils/dimens.dart';
import 'package:presentation/utils/images/paths.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
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
      child: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: PrimaryColors.primaryBackgroundColor,
        elevation: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              ImagesPath.movieIcon,
              color: PrimaryColors.whiteWithOpacity80,
            ),
            activeIcon: SvgPicture.asset(
              ImagesPath.movieIcon,
              color: PrimaryColors.primarySelected,
            ),
            label: l10n.title,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              ImagesPath.tickerIcon,
              color: PrimaryColors.whiteWithOpacity80,
            ),
            activeIcon: SvgPicture.asset(
              ImagesPath.tickerIcon,
              color: PrimaryColors.primarySelected,
            ),
            label: l10n.showtime,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              ImagesPath.alarmIcon,
              color: PrimaryColors.whiteWithOpacity80,
            ),
            activeIcon: SvgPicture.asset(
              ImagesPath.alarmIcon,
              color: PrimaryColors.primarySelected,
            ),
            label: l10n.notifications,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              ImagesPath.personIcon,
              color: PrimaryColors.whiteWithOpacity80,
            ),
            activeIcon: SvgPicture.asset(
              ImagesPath.personIcon,
              color: PrimaryColors.primarySelected,
            ),
            label: l10n.titleProfile,
          ),
        ],
        currentIndex: bloc.selectedIndex,
        onTap: (index) {
          bloc.onItemTapped(index);
        },
      ),
    );
  }
}
