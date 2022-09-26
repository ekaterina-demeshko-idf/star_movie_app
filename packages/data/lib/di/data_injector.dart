import 'package:data/interceptor/interceptor.dart';
import 'package:domain/repository/tmdb_api_repository.dart';
import 'package:domain/repository/trakt_api_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
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
    _buildDio([
      GetIt.I.get<ApiKeyInterceptor>(),
      GetIt.I.get<LogInterceptor>(),
    ]),
  );

  GetIt.I.registerSingleton<ApiBaseService<ServicePayload>>(
    ApiServiceImpl(GetIt.I.get<Dio>()),
  );
}

void _initInterceptorModule() {
  GetIt.I.registerSingleton<ApiKeyInterceptor>(
    ApiKeyInterceptor(),
  );

  GetIt.I.registerSingleton<LogInterceptor>(
    LogInterceptor(requestBody: true, responseBody: true),
  );
}

void _initRepositoryModule() {
  GetIt.I.registerSingleton<TraktAPIRepository>(
    TraktAPIRepositoryImpl(
      GetIt.I.get<ApiBaseService>(),
    ),
  );

  GetIt.I.registerSingleton<TmdbAPIRepository>(
    TmdbAPIRepositoryImpl(
      GetIt.I.get<ApiBaseService>(),
    ),
  );
}

Dio _buildDio(List<Interceptor> interceptors) {
  final options = BaseOptions(
    sendTimeout: Config.sendTimeout,
    receiveTimeout: Config.receiveTimeout,
    connectTimeout: Config.connectTimeout,
  );

  final dio = Dio(options);
  dio.interceptors.addAll(interceptors);
  return dio;
}
