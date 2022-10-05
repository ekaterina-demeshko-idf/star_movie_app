import 'package:domain/usecase/check_user_usecase.dart';
import 'package:domain/usecase/facebook_auth_usecase.dart';
import 'package:domain/usecase/get_cast_usecase.dart';
import 'package:domain/usecase/google_auth_usecase.dart';
import 'package:domain/usecase/imitate_api_call_usecase.dart';
import 'package:domain/usecase/get_movie_list_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/screen/home/home_bloc.dart';
import 'package:presentation/screen/splash/splash_bloc.dart';
import '../app/app_bloc.dart';
import '../navigation/app_navigator.dart';
import '../mappers/presentation_view_mapper.dart';
import '../screen/details/details_bloc.dart';
import '../screen/login/login_bloc.dart';

void initPresentationInjector() {
  _initSplashScreenModule();
  _initAppModule();
  _initHomeScreenModule();
  _initDetailsScreenModule();
  _initLoginScreenModule();
}

void _initSplashScreenModule() {
  GetIt.I.registerFactory<SplashBloc>(
    () => SplashBloc(
      GetIt.I.get<ImitateApiCallUseCase>(),
    ),
  );
}

void _initHomeScreenModule() {
  GetIt.I.registerFactory<HomeViewMapper>(
    () => HomeViewMapper(),
  );
  GetIt.I.registerFactory<HomeBloc>(
    () => HomeBloc(
      GetIt.I.get<GetMovieListUseCase>(),
      GetIt.I.get<HomeViewMapper>(),
    ),
  );
}

void _initDetailsScreenModule() {
  GetIt.I.registerFactory<DetailsBloc>(
    () => DetailsBloc(
      GetIt.I.get<GetCastUseCase>(),
    ),
  );
}

void _initLoginScreenModule() {
  GetIt.I.registerFactory<LoginBloc>(
    () => LoginBloc(
      GetIt.I.get<CheckUserUseCase>(),
      GetIt.I.get<GoogleAuthUseCase>(),
      GetIt.I.get<FacebookAuthUseCase>(),
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
