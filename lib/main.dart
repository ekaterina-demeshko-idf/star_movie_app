import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie/flavors/env_enum.dart';
import 'package:presentation/app/my_app.dart';
import 'di/app_injector.dart';
import 'flavors/config_data.dart';
import 'flavors/config_presentation.dart';

void mainCommon({Environment env = Environment.production}) async {
  WidgetsFlutterBinding.ensureInitialized();
  final currentEnv = env == Environment.production ? 'prod' : 'sandbox';
  final jsonConfig = await readJson(currentEnv);
  final ConfigData configData = ConfigData.fromJson(jsonConfig);
  final ConfigPresentation configPresentation =
      ConfigPresentation.fromJson(jsonConfig);
  initAppInjector(configData);
  runApp(MyApp(configPresentation.appTitle));
}

Future<Map<String, dynamic>> readJson(String env) async {
  final String response = await rootBundle
      .loadString('resources/flavors_config/${env}_config.json');
  final Map<String, dynamic> data = await json.decode(response);
  return data;
}
