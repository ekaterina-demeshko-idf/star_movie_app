import 'package:dio/dio.dart';
import "package:yaml/yaml.dart";
import 'package:data/utils/const.dart';
import 'package:domain/utils/getSecrets.dart';

class TraktApiKeyInterceptor extends Interceptor {
  late YamlMap secrets;
  late String apiKey = '';

  TraktApiKeyInterceptor(String apiKeyGet) {
    _getAsyncSecrets();
    apiKey = apiKeyGet;
  }

  void _getAsyncSecrets() async {
    secrets = await getSecrets();
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers[Config.traktApiKey] = apiKey;//secrets["API_KEY"];
    return handler.next(options);
  }
}
