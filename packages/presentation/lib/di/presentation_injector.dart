import 'package:get_it/get_it.dart';

void initPresentationInjector() {
  _initMainScreenModule();
}

void _initMainScreenModule() {
  GetIt.I.registerFactory(
    () => {},
  );
}
