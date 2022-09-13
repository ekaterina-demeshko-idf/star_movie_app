import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:presentation/utils/colors.dart';
import '../../base/bloc_data.dart';
import '../../base/bloc_screen.dart';
import '../../navigation/base_arguments.dart';
import '../../navigation/base_page.dart';
import '../../utils/images/paths.dart';
import '../../utils/widgets/homeContent.dart';
import '../../utils/widgets/homeSkelet.dart';
import '../../utils/text_styles.dart';
import 'home_bloc.dart';

class HomeScreenArguments extends BaseArguments {
  List<dynamic>? movieResponse;
  List<dynamic>? anticipatedResponse;

  HomeScreenArguments({
    required this.movieResponse,
    required this.anticipatedResponse,
    Function(dynamic value)? result,
  }) : super(result: result);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const _routeName = '/HomeScreen';

  static BasePage page(HomeScreenArguments arguments) => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (context) => const HomeScreen(),
        arguments: arguments,
      );

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends BlocScreenState<HomeScreen, HomeBloc>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BlocData>(
        stream: bloc.dataStream,
        builder: (context, snapshot) {
          final data = snapshot.data;
          final screenData = data?.data;
          if (data != null) {
            final blocData = data.data;
            return Scaffold(
              appBar: AppBar(
                  backgroundColor:
                      const Color(PrimaryColors.primaryBackgroundColor),
                  elevation: 0,
                  title: Text(
                    'Star Movie',
                    style: AppTextStyles.headerStyle(
                      AppTextStyles.header,
                      fontWeight: AppFonts.bold,
                      fontFamily: AppFonts.sfProText,
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () => {},
                      icon: SvgPicture.asset(ImagesPath.searchIcon),
                      color: Colors.white,
                    ),
                  ]),
              body: data.isLoading
                  ? const HomeSkelet()
                  : HomeContent(screenData: screenData),
              bottomNavigationBar: Container(
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
                        color: const Color(PrimaryColors.whiteWithOpacity),
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
                        color: const Color(PrimaryColors.whiteWithOpacity),
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
                        color: const Color(PrimaryColors.whiteWithOpacity),
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
                        color: const Color(PrimaryColors.whiteWithOpacity),
                      ),
                      activeIcon: SvgPicture.asset(
                        ImagesPath.personIcon,
                        color: const Color(PrimaryColors.primarySelected),
                      ),
                      label: 'School',
                    ),
                  ],
                  currentIndex: blocData.selectedIndex,
                  onTap: bloc.onItemTapped,
                ),
              ),
              backgroundColor:
                  const Color(PrimaryColors.primaryBackgroundColor),
            );
          } else {
            return Scaffold(
              body: Container(),
            );
          }
        });
  }
}
