import 'dart:convert';
import 'dart:io' show Platform;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie/flavors/env_enum.dart';
import 'package:presentation/app/my_app.dart';
import 'package:presentation/models/config_presentation.dart';
import 'package:data/flavors_config/config_data.dart';
import 'di/app_injector.dart';
import 'firebase_options.dart';

void mainCommon({Environment env = Environment.prod}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseCrashlytics.instance
      .setCrashlyticsCollectionEnabled(!kDebugMode);
  final currentEnv = env.name;
  final jsonConfig = await readJson(currentEnv);
  final ConfigData configData = ConfigData.fromJson(jsonConfig);
  final ConfigPresentation configPresentation =
      ConfigPresentation.fromJson(jsonConfig);
  await initAppInjector(configData);
  runApp(MyApp(configPresentation));
}

Future<Map<String, dynamic>> readJson(String env) async {
  final String response = await rootBundle
      .loadString('resources/flavors_config/${env}_config.json');
  final Map<String, dynamic> data = await json.decode(response);
  return data;
}
