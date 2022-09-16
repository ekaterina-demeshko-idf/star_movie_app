import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presentation/utils/colors.dart';
import 'app_bloc.dart';
import 'data/app_data.dart';
import '../base/bloc_data.dart';
import '../base/bloc_screen.dart';
import '../../utils/images/paths.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends BlocScreenState<StatefulWidget, AppBloc> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        canvasColor: const Color(PrimaryColors.primaryBackgroundColor),
      ),
      home: StreamBuilder<BlocData>(
        stream: bloc.dataStream,
        builder: (context, result) {
          final appData = result.data?.data;
          if (appData is AppData) {
            return Scaffold(
              body: Navigator(
                onPopPage: (Route<dynamic> route, dynamic result) {
                  bloc.handleRemoveRouteSettings(route.settings);
                  return route.didPop(result);
                },
                pages: appData.pages.toList(),
              ),
              bottomNavigationBar: appData.hideNavBar
                  ? const SizedBox.shrink()
                  : Container(
                      padding: const EdgeInsets.only(bottom: 15),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 0.5,
                            color: Color(PrimaryColors.primaryUnselected),
                          ),
                        ),
                      ),
                      child: BottomNavigationBar(
                        showSelectedLabels: false,
                        showUnselectedLabels: false,
                        backgroundColor:
                            const Color(PrimaryColors.primaryBackgroundColor),
                        elevation: 0,
                        items: <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(
                              ImagesPath.movieIcon,
                              color:
                                  const Color(PrimaryColors.whiteWithOpacity),
                            ),
                            activeIcon: SvgPicture.asset(
                              ImagesPath.movieIcon,
                              color: const Color(PrimaryColors.primarySelected),
                            ),
                            label: 'Home',
                          ),
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(
                              ImagesPath.tickerIcon,
                              color:
                                  const Color(PrimaryColors.whiteWithOpacity),
                            ),
                            activeIcon: SvgPicture.asset(
                              ImagesPath.tickerIcon,
                              color: const Color(PrimaryColors.primarySelected),
                            ),
                            label: 'Business',
                          ),
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(
                              ImagesPath.alarmIcon,
                              color:
                                  const Color(PrimaryColors.whiteWithOpacity),
                            ),
                            activeIcon: SvgPicture.asset(
                              ImagesPath.alarmIcon,
                              color: const Color(PrimaryColors.primarySelected),
                            ),
                            label: 'School',
                          ),
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(
                              ImagesPath.personIcon,
                              color:
                                  const Color(PrimaryColors.whiteWithOpacity),
                            ),
                            activeIcon: SvgPicture.asset(
                              ImagesPath.personIcon,
                              color: const Color(PrimaryColors.primarySelected),
                            ),
                            label: 'School',
                          ),
                        ],
                        currentIndex: appData.selectedIndex,
                        onTap: bloc.onItemTapped,
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
