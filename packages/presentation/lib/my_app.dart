import 'package:flutter/material.dart';
import 'package:presentation/utils/colors.dart';
import 'app/app_bloc.dart';
import 'app/data/app_data.dart';
import 'base/bloc_data.dart';
import 'base/bloc_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends BlocScreenState<StatefulWidget, AppBloc> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        canvasColor: const Color(PrimaryColors.primaryBackgroundColor),
      ),
      home: StreamBuilder<BlocData>(
        stream: bloc.dataStream,
        builder: (context, result) {
          final blocData = result.data;
          final appData = blocData?.data;
          if (appData is AppData) {
            return Scaffold(
              body: Navigator(
                onPopPage: (Route<dynamic> route, dynamic result) {
                  bloc.handleRemoveRouteSettings(route.settings);
                  return route.didPop(result);
                },
                pages: appData.pages.toList(),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
