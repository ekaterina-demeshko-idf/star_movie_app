import 'package:data/di/data_injector.dart';
import 'package:domain/di/domain_injector.dart';
import 'package:presentation/di/presentation_injector.dart';
import 'package:data/flavors_config/config_data.dart';

void initAppInjector(ConfigData configData) {
  initDataInjector(configData);
  initDomainInjector();
  initPresentationInjector();
}
