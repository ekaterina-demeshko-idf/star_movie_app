import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie/flavor_config.dart';
import 'package:presentation/app/my_app.dart';
import 'config.dart';
import 'config_data.dart';
import 'config_presentation.dart';
import 'di/app_injector.dart';

void mainCommon({Environment env = Environment.production}) async {
  WidgetsFlutterBinding.ensureInitialized();
  final currentEnv = env == Environment.production ? 'prod' : 'sandbox';
  final ConfigData configData = ConfigData.fromJson(await readJson(currentEnv));
  final ConfigPresentation configPresentation =
      ConfigPresentation.fromJson(await readJson(currentEnv));
  initAppInjector(
    configData,
    configPresentation,
  );
  runApp(MyApp(configPresentation.appTitle));
}

Future<Map<String, dynamic>> readJson(String env) async {
  final String response = await rootBundle
      .loadString('resources/flavors_config/${env}_config.json');
  final Map<String, dynamic> data = await json.decode(response);
  return data;
}
