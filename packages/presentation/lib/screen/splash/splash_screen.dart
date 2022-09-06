import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:presentation/screen/splash/splash_bloc.dart';
import '../../navigation/base_page.dart';
import '../../utils/colors.dart';
import '../../base/bloc_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const _routeName = '/SplashScreen';

  static BasePage page() => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (context) => const SplashScreen(),
      );

  @override
  State createState() => _SplashScreenState();
}

class _SplashScreenState extends BlocScreenState<SplashScreen, SplashBloc> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.dataStream,
        builder: (context, snapshot) {
          return Scaffold(
            body: Center(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(PrimaryColors.primaryColor),
                      Color(PrimaryColors.primaryGradientBottom),
                    ],
                  ),
                ),
                child: Center(
                  child: SvgPicture.asset('resources/images/Group.svg'),
                ),
              ),
            ),
          );
        });
  }
}
