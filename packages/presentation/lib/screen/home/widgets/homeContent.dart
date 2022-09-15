import 'package:flutter/material.dart';
import './tabbar.dart';
import 'anticipated.dart';
import 'nowShowing.dart';

class HomeContent extends StatelessWidget {
  final bloc;
  final screenData;

  const HomeContent({
    Key? key,
    required this.screenData,
    required this.bloc,
  }) : super(key: key);

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
                      NowShowingWidget(
                        screenData: screenData,
                        bloc: bloc,
                      ),
                      AnticipatedWidget(
                        screenData: screenData,
                        bloc: bloc,
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
