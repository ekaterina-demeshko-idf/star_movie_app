import 'package:data/di/data_injector.dart';
import 'package:domain/di/domain_injector.dart';
import 'package:movie/flavors/config_data.dart';
import 'package:movie/flavors/config_presentation.dart';
import 'package:presentation/di/presentation_injector.dart';


void initAppInjector(ConfigData configData, ConfigPresentation configPresentation) { //config data config presentation
  initDataInjector(configData.apiKey, configData.baseUrl); //configData.apiKey, configData.baseUrl
  initDomainInjector();
  initPresentationInjector(); //configPresentation
}
