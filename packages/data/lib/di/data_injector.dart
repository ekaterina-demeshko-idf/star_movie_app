import 'package:data/interceptor/trakt_interceptor.dart';
import 'package:domain/repository/tmdb_api_repository.dart';
import 'package:domain/repository/trakt_api_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../interceptor/tmdb_interceptor.dart';
import '../repository/tmdb_repository.dart';
import '../repository/trakt_repository.dart';
import '../service/api_base_service.dart';
import '../service/service_payload.dart';
import '../utils/const.dart';

void initDataInjector() {
  _initInterceptorModule();
  _initApiModule();
  _initRepositoryModule();
}

void _initApiModule() {
  GetIt.I.registerSingleton<Dio>(
    _buildTraktApiDio([
      GetIt.I.get<TraktApiKeyInterceptor>(),
      GetIt.I.get<LogInterceptor>(),
    ]),
    instanceName: 'Trakt',
  );

  GetIt.I.registerSingleton<Dio>(
    _buildTMDBApiDio([
      GetIt.I.get<TMDBApiKeyInterceptor>(),
      GetIt.I.get<LogInterceptor>(),
    ]),
    instanceName: 'TMDB',
  );

  GetIt.I.registerSingleton<ApiBaseService<ServicePayload>>(
      ApiServiceImpl(GetIt.I.get<Dio>(instanceName: 'Trakt')),
      instanceName: 'TraktService');

  GetIt.I.registerSingleton<ApiBaseService<ServicePayload>>(
      ApiServiceImpl(GetIt.I.get<Dio>(instanceName: 'TMDB')),
      instanceName: 'TMDBService');
}

void _initInterceptorModule() {
  GetIt.I.registerSingleton<TraktApiKeyInterceptor>(
    TraktApiKeyInterceptor(),
  );

  GetIt.I.registerSingleton<TMDBApiKeyInterceptor>(
    TMDBApiKeyInterceptor(),
  );

  GetIt.I.registerSingleton<LogInterceptor>(
    LogInterceptor(requestBody: true, responseBody: true),
  );
}

void _initRepositoryModule() {
  GetIt.I.registerSingleton<TraktAPIRepository>(
    TraktAPIRepositoryImpl(
      GetIt.I.get<ApiBaseService>(instanceName: 'TraktService'),
    ),
  );

  GetIt.I.registerSingleton<TmdbAPIRepository>(
    TmdbAPIRepositoryImpl(
      GetIt.I.get<ApiBaseService>(instanceName: 'TMDBService'),
    ),
  );
}

Dio _buildTraktApiDio(List<Interceptor> interceptors) {
  final options = BaseOptions(
    sendTimeout: Config.sendTimeout,
    receiveTimeout: Config.receiveTimeout,
    connectTimeout: Config.connectTimeout,
    baseUrl: Config.traktBasePath,
  );

  final dio = Dio(options);
  dio.interceptors.addAll(interceptors);
  return dio;
}

Dio _buildTMDBApiDio(List<Interceptor> interceptors) {
  final options = BaseOptions(
    sendTimeout: Config.sendTimeout,
    receiveTimeout: Config.receiveTimeout,
    connectTimeout: Config.connectTimeout,
    baseUrl: Config.tmdbBasePath,
  );
  final dio = Dio(options);
  dio.interceptors.addAll(interceptors);
  return dio;
}
