import 'package:flutter/material.dart';

class TabBarHomeScreen extends StatelessWidget {
  const TabBarHomeScreen({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      unselectedLabelColor: Colors.grey,
      labelColor: Colors.white,
      indicatorColor: Colors.red,
      indicatorWeight: 2,
      indicator: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(25),
      ),
      controller: tabController,
      tabs: [
        Tab(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.play_circle_fill_rounded),
              SizedBox(width: 8),
              Text('Now Showing'),
            ],
          ),
        ),
        const Tab(
          text: 'Coming Soon',
        ),
      ],
    );
  }
}
