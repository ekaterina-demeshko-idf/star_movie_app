import 'package:dio/dio.dart';
import "package:yaml/yaml.dart";
import 'package:data/utils/const.dart';
import 'package:domain/utils/getSecrets.dart';

class ApiKeyInterceptor extends Interceptor {
  late YamlMap secrets;

  ApiKeyInterceptor() {
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
    options.headers[Config.traktApiKey] = secrets["API_KEY"];
    return handler.next(options);
  }
}
