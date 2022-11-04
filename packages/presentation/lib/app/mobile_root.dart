import 'package:flutter/material.dart';
import 'package:presentation/app/app_bloc.dart';
import 'package:presentation/app/data/app_data.dart';
import 'package:presentation/app/widgets/bottom_navigation.dart';

class MobileRoot extends StatelessWidget {
  const MobileRoot({
    Key? key,
    required this.bloc,
    required this.appData,
  }) : super(key: key);

  final AppBloc bloc;
  final AppData appData;

  @override
  Widget build(BuildContext context) {
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
          : BottomNavigation(bloc: bloc),
    );
  }
}
