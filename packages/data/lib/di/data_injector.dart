import 'package:data/interceptor/interceptor.dart';
import 'package:domain/repository/movie_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../repository/movie_repository.dart';
import '../service/api_base_service.dart';
import '../service/service_payload.dart';
import '../utils/const.dart';

void initDataInjector() {
  _initApiModule();
  _initRepositoryModule();
}

void _initApiModule() {
  GetIt.I.registerSingleton<Dio>(
    _buildDio(),
    instanceName: "Dio",
  );

  GetIt.I.registerSingleton<ApiBaseService<ServicePayload>>(
    ApiServiceImpl(GetIt.I.get(instanceName: "Dio")),
    instanceName: "Service",
  );
}

void _initRepositoryModule() {
  GetIt.I.registerSingleton<NetworkRepository>(
    NetworkRepositoryImpl(
      GetIt.I.get<ApiBaseService>(instanceName: "Service"),
    ),
  );
}

Dio _buildDio() {
  final options = BaseOptions(
    sendTimeout: C.sendTimeout,
    receiveTimeout: C.receiveTimeout,
    connectTimeout: C.connectTimeout,
  );

  final dio = Dio(options);
  dio.interceptors.addAll([
    ApiKeyInterceptor(),
    LogInterceptor(requestBody: true, responseBody: true),
  ]);
  return dio;
}
