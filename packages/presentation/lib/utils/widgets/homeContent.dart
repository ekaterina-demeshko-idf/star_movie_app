import 'package:flutter/material.dart';
import 'package:presentation/utils/widgets/tabbar.dart';
import 'anticipated.dart';
import 'nowShowing.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({
    Key? key,
    required this.screenData,
  }) : super(key: key);

  final screenData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTabController(
          length: 2,
          child: Expanded(
            child: Column(
              children: <Widget>[
                const TabBarContainer(),
                Expanded(
                  child: TabBarView(
                    children: [
                      NowShowing(
                        screenData: screenData,
                      ),
                      Anticipated(
                        screenData: screenData,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
