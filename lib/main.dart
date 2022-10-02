import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie/flavors/env_enum.dart';
import 'package:presentation/app/my_app.dart';
import 'package:presentation/models/config_presentation.dart';
import 'package:data/flavors_config/config_data.dart';
import 'di/app_injector.dart';

void mainCommon({Environment env = Environment.production}) async {
  WidgetsFlutterBinding.ensureInitialized();
  final currentEnv = env == Environment.production
      ? Environment.production.name
      : Environment.sandbox.name;
  final jsonConfig = await readJson(currentEnv);
  final ConfigData configData = ConfigData.fromJson(jsonConfig);
  final ConfigPresentation configPresentation =
      ConfigPresentation.fromJson(jsonConfig);
  initAppInjector(configData);
  runApp(MyApp(configPresentation));
}

Future<Map<String, dynamic>> readJson(String env) async {
  final String response = await rootBundle
      .loadString('resources/flavors_config/${env}_config.json');
  final Map<String, dynamic> data = await json.decode(response);
  return data;
}
