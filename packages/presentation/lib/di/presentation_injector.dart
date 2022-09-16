import 'package:domain/usecase/imitate_api_call_usecase.dart';
import 'package:domain/usecase/get_movie_response_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/screen/home/home_bloc.dart';
import 'package:presentation/screen/splash/splash_bloc.dart';
import '../app/app_bloc.dart';
import '../navigation/app_navigator.dart';
import '../screen/home/home_view_mapper.dart';

void initPresentationInjector() {
  _initSplashScreenModule();
  _initAppModule();
  _initHomeScreenModule();
}

void _initSplashScreenModule() {
  GetIt.I.registerFactory<SplashBloc>(
    () => SplashBloc(
      GetIt.I.get<ImitateApiCallUseCase>(),
    ),
  );
}

void _initHomeScreenModule() {
  GetIt.I.registerFactory<HomeViewMapper>(() => HomeViewMapper());
  GetIt.I.registerFactory<HomeBloc>(
    () => HomeBloc(
      GetIt.I.get<GetMovieResponseUseCase>(),
      GetIt.I.get<HomeViewMapper>(),
    ),
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
