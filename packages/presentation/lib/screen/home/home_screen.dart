import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:presentation/utils/colors.dart';
import '../../base/bloc_screen.dart';
import '../../navigation/base_arguments.dart';
import '../../navigation/base_page.dart';
import '../../utils/images/paths.dart';
import './widgets/home_content.dart';
import '../../utils/text_styles.dart';
import 'home_bloc.dart';

class HomeScreenArguments extends BaseArguments {
  HomeScreenArguments({
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
        hideNavBar: false,
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
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(PrimaryColors.primaryBackgroundColor),
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
      body: const HomeContent(),
      backgroundColor: const Color(PrimaryColors.primaryBackgroundColor),
    );
  }
}
