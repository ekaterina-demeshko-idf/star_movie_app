import 'package:dio/dio.dart';
import "package:yaml/yaml.dart";
import 'package:data/utils/const.dart';
import 'package:domain/utils/getSecrets.dart';

class ApiKeyInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    YamlMap secrets = await getSecrets();
    options.headers[Config.traktApiKey] = secrets["API_KEY"];
    return handler.next(options);
  }
}
