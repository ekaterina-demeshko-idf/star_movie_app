import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:presentation/app/app_bloc.dart';
import 'package:presentation/app/widgets/item.dart';
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
          Item.getBottomItem(
            ImagesPath.movieIcon,
            l10n.title,
          ),
          Item.getBottomItem(
            ImagesPath.tickerIcon,
            l10n.showtime,
          ),
          Item.getBottomItem(
            ImagesPath.alarmIcon,
            l10n.notifications,
          ),
          Item.getBottomItem(
            ImagesPath.personIcon,
            l10n.titleProfile,
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
