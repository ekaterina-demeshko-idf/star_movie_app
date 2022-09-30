import 'package:data/di/data_injector.dart';
import 'package:domain/di/domain_injector.dart';
import 'package:movie/config_data.dart';
import 'package:movie/config_presentation.dart';
import 'package:movie/flavor_config.dart';
import 'package:presentation/di/presentation_injector.dart';

import '../config.dart';

void initAppInjector(ConfigData configData, ConfigPresentation configPresentation) { //config data config presentation
  initDataInjector(configData.apiKey, configData.baseUrl); //configData.apiKey, configData.baseUrl
  initDomainInjector();
  initPresentationInjector(); //configPresentation
}
