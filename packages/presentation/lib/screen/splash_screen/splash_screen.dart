import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const gradientTopColor = Color(0xFFE51937);
  static const gradientBottomColor = Color(0xFFDB5252);

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
                gradientTopColor,
                gradientBottomColor,
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
