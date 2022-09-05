import 'package:flutter/material.dart';
import '../../navigation/base_page.dart';
import '../../utils/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const _routeName = '/SplashScreen';

  static BasePage page() => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (context) => const SplashScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(CustomColors.gradientTopColor),
                Color(CustomColors.gradientBottomColor),
              ],
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.energy_savings_leaf_outlined,
              color: Colors.white,
              size: 162,
            ),
          ),
        ),
      ),
    );
  }
}
