import 'package:dio/dio.dart';
import "package:yaml/yaml.dart";
import 'package:domain/utils/getSecrets.dart';

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
      'api_key': secrets["TMDB_API_KEY"],
    });
    return handler.next(options);
  }
}
