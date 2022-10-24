import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/database/database.dart';
import 'package:data/interceptor/trakt_interceptor.dart';
import 'package:data/repository/firestore_repository.dart';
import 'package:data/repository/local_storage_repository.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:domain/repository/local_storage_repository.dart';
import 'package:domain/repository/remote_db_repository.dart';
import 'package:domain/repository/tmdb_api_repository.dart';
import 'package:domain/repository/trakt_api_repository.dart';
import 'package:domain/services/analytics_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import '../flavors_config/config_data.dart';
import '../interceptor/tmdb_interceptor.dart';
import '../repository/auth_repository.dart';
import '../repository/tmdb_repository.dart';
import '../repository/trakt_repository.dart';
import '../service/api_base_service.dart';
import '../service/firebase_analytics.dart';
import '../service/service_payload.dart';
import '../utils/apiPath.dart';
import '../utils/const.dart';

Future<void> initDataInjector(ConfigData configData) async {
  _initInterceptorModule(configData.apiKey);
  _initApiModule(configData.baseUrl);
  await _initDatabaseModule();
  await _initRepositoryModule();
}

void _initApiModule(String baseUrl) {
  GetIt.I.registerSingleton<Dio>(
    _buildTraktApiDio([
      GetIt.I.get<TraktApiKeyInterceptor>(),
      GetIt.I.get<LogInterceptor>(),
    ], baseUrl),
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
    instanceName: 'TraktService',
  );

  GetIt.I.registerSingleton<ApiBaseService<ServicePayload>>(
    ApiServiceImpl(GetIt.I.get<Dio>(instanceName: 'TMDB')),
    instanceName: 'TMDBService',
  );

  GetIt.I.registerSingleton<FirebaseAnalytics>(FirebaseAnalytics.instance);
}

void _initInterceptorModule(String apiKey) {
  GetIt.I.registerSingleton<TraktApiKeyInterceptor>(
    TraktApiKeyInterceptor(apiKey),
  );

  GetIt.I.registerSingleton<TMDBApiKeyInterceptor>(
    TMDBApiKeyInterceptor(),
  );

  GetIt.I.registerSingleton<LogInterceptor>(
    LogInterceptor(requestBody: true, responseBody: true),
  );
}

Future<void> _initDatabaseModule() async {
  GetIt.I.registerSingleton<MovieDatabase>(
    MovieDatabase(),
  );

  GetIt.I.registerSingleton<Database>(
    await openDatabase(
      MovieDatabase.name,
      onCreate: (db, version) =>
          GetIt.I.get<MovieDatabase>().createDB(db, version),
      onUpgrade: (db, oldVersion, newVersion) =>
          GetIt.I.get<MovieDatabase>().upgradeDB(db, oldVersion, newVersion),
      version: MovieDatabase.version,
    ),
  );
}

Future<void> _initRepositoryModule() async {
  GetIt.I.registerSingleton<AnalyticsService>(
    AnalyticsServiceImpl(
      GetIt.I.get<FirebaseAnalytics>(),
    ),
  );
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
  GetIt.I.registerSingletonAsync<SharedPreferences>(
    () async => await SharedPreferences.getInstance(),
  );
  GetIt.I.registerSingleton<LocalStorageRepository>(
    LocalStorageRepositoryImpl(
      await GetIt.I.getAsync<SharedPreferences>(),
      GetIt.I.get<Database>(),
    ),
  );
  GetIt.I.registerSingleton<GoogleSignIn>(GoogleSignIn());
  GetIt.I.registerSingleton<FacebookAuth>(FacebookAuth.instance);
  GetIt.I.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  GetIt.I.registerSingleton<RemoteDBRepository>(
    FirestoreRepositoryImpl(
      GetIt.I.get<FirebaseFirestore>(),
    ),
  );
  GetIt.I.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      GetIt.I.get<GoogleSignIn>(),
      GetIt.I.get<FacebookAuth>(),
    ),
  );
}

Dio _buildTraktApiDio(List<Interceptor> interceptors, String baseUrl) {
  final options = BaseOptions(
    sendTimeout: Config.sendTimeout,
    receiveTimeout: Config.receiveTimeout,
    connectTimeout: Config.connectTimeout,
    baseUrl: baseUrl,
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
    baseUrl: ApiPath.tmdbBasePath,
  );
  final dio = Dio(options);
  dio.interceptors.addAll(interceptors);
  return dio;
}
