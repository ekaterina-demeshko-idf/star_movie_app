import 'package:flutter/material.dart';
import 'package:presentation/app/my_app.dart';
import 'di/app_injector.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initAppInjector();
  runApp(const MyApp());
}