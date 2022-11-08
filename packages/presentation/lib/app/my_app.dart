import 'package:flutter/material.dart';
import 'package:presentation/app/desktop_root.dart';
import 'package:presentation/app/mobile_root.dart';
import 'package:presentation/utils/colors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:presentation/utils/responsive.dart';
import '../models/config_presentation.dart';
import 'app_bloc.dart';
import 'data/app_data.dart';
import '../base/bloc_data.dart';
import '../base/bloc_screen.dart';

class MyApp extends StatefulWidget {
  final ConfigPresentation configPresentation;

  const MyApp(this.configPresentation, {Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends BlocScreenState<MyApp, AppBloc> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.configPresentation.appTitle,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('be', ''),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        canvasColor: PrimaryColors.primaryBackgroundColor,
      ),
      home: StreamBuilder<BlocData>(
        stream: bloc.dataStream,
        builder: (context, result) {
          final appData = result.data?.data;
          if (appData is AppData) {
            return Responsive.isMediumScreen(context)
                ? DesktopRoot(
                    appData: appData,
                    bloc: bloc,
                  )
                : MobileRoot(
                    bloc: bloc,
                    appData: appData,
                  );
          }
          return Container();
        },
      ),
    );
  }
}
