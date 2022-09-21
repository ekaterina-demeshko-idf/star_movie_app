import 'package:data/di/data_injector.dart';
import 'package:domain/di/domain_injector.dart';
import 'package:presentation/di/presentation_injector.dart';

void initAppInjector() {
  initDataInjector();
  initDomainInjector();
  initPresentationInjector();
}
