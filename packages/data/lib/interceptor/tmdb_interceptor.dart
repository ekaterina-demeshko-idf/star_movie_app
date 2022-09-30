import 'package:dio/dio.dart';
import "package:yaml/yaml.dart";
import 'package:domain/utils/getSecrets.dart';

import '../utils/const.dart';

class TMDBApiKeyInterceptor extends Interceptor {
  late YamlMap secrets;

  TMDBApiKeyInterceptor() {
    _getAsyncSecrets();
  }

  void _getAsyncSecrets() async {
    secrets = await getSecrets();
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.queryParameters.addAll({
      'api_key': secrets[Config.tmdbApiKey],
    });
    return handler.next(options);
  }
}
