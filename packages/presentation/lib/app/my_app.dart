import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/utils/colors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:presentation/utils/dimens.dart';
import 'package:presentation/utils/responsive.dart';
import '../models/config_presentation.dart';
import 'app_bloc.dart';
import 'data/app_data.dart';
import '../base/bloc_data.dart';
import '../base/bloc_screen.dart';
import '../../utils/images/paths.dart';

class MyApp extends StatefulWidget {
  final ConfigPresentation configPresentation;

  const MyApp(this.configPresentation, {Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends BlocScreenState<MyApp, AppBloc> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.configPresentation.appTitle,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('be', ''),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        canvasColor: PrimaryColors.primaryBackgroundColor,
      ),
      home: StreamBuilder<BlocData>(
        stream: bloc.dataStream,
        builder: (context, result) {
          final appData = result.data?.data;
          if (appData is AppData) {
            final l10n = AppLocalizations.of(context)!;
            return Scaffold(
              body: Row(
                children: [
                  appData.hideNavBar || !(Responsive.switchToSideBar(context))
                      ? const SizedBox.shrink()
                      : Container(
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
                            backgroundColor:
                                PrimaryColors.primaryBackgroundColor,
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
                        ),
                  Expanded(
                    child: Navigator(
                      onPopPage: (Route<dynamic> route, dynamic result) {
                        bloc.handleRemoveRouteSettings(route.settings);
                        return route.didPop(result);
                      },
                      pages: appData.pages.toList(),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: appData.hideNavBar ||
                      Responsive.switchToSideBar(context)
                  ? const SizedBox.shrink()
                  : Container(
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
                            label: 'Home',
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
                            label: 'Ticket',
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
                            label: 'Notifications',
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
                            label: 'Profile',
                          ),
                        ],
                        currentIndex: bloc.selectedIndex,
                        onTap: (index) {
                          bloc.onItemTapped(index);
                        },
                      ),
                    ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
