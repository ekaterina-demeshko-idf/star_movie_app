import 'package:get_it/get_it.dart';
import 'package:presentation/screen/home/home_bloc.dart';
import 'package:presentation/screen/splash/splash_bloc.dart';
import '../app/app_bloc.dart';
import '../navigation/app_navigator.dart';

void initPresentationInjector() {
  _initSplashScreenModule();
  _initAppModule();
  _initHomeScreenModule();
}

void _initSplashScreenModule() {
  GetIt.I.registerFactory<SplashBloc>(
    () => SplashBloc(),
  );
}

void _initHomeScreenModule() {
  GetIt.I.registerFactory<HomeBloc>(
    () => HomeBloc(),
  );
}

void _initAppModule() {
  GetIt.I.registerFactory<AppBloc>(
    () => AppBloc(),
  );
  GetIt.I.registerSingleton<AppNavigator>(
    AppNavigator(),
  );
}
