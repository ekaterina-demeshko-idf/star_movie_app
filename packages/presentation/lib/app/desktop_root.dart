import 'package:flutter/material.dart';
import 'package:presentation/app/widgets/side_navigation.dart';
import 'package:presentation/app/app_bloc.dart';
import 'package:presentation/app/data/app_data.dart';
import 'package:window_size/window_size.dart';

class DesktopRoot extends StatelessWidget {
  const DesktopRoot({
    Key? key,
    required this.appData,
    required this.bloc,
  }) : super(key: key);

  final AppData appData;
  final AppBloc bloc;

  @override
  Widget build(BuildContext context) {
    setWindowMinSize(const Size(400, 500));
    return Scaffold(
      body: Row(
        children: [
          appData.hideNavBar
              ? const SizedBox.shrink()
              : SideNavigation(bloc: bloc),
          Expanded(
            child: Navigator(
              onPopPage: (Route<dynamic> route, dynamic result) {
                bloc.handleRemoveRouteSettings(route.settings);
                return route.didPop(result);
              },
              pages: appData.pages.toList(),
            ),
          ),
        ],
      ),
    );
  }
}
