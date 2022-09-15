import 'package:data/interceptor/interceptor.dart';
import 'package:domain/repository/movie_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../repository/movie_repository.dart';
import '../service/api_base_service.dart';
import '../service/service_payload.dart';
import '../utils/const.dart';
import 'package:data/interceptor/interceptor.dart';

void initDataInjector()  {
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
  GetIt.I.registerSingleton<NetworkRepository>(
    NetworkRepositoryImpl(
      GetIt.I.get<ApiBaseService>(),
    ),
  );
}

Dio _buildDio(List<Interceptor> interceptors) {
  final options = BaseOptions(
    sendTimeout: C.sendTimeout,
    receiveTimeout: C.receiveTimeout,
    connectTimeout: C.connectTimeout,
  );

  final dio = Dio(options);
  dio.interceptors.addAll(interceptors);
  return dio;
}
