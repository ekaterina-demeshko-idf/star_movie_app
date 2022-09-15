import 'package:dio/dio.dart';
import "package:flutter/services.dart" as s;
import "package:yaml/yaml.dart";

class ApiKeyInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['trakt-api-key'] = await getSecrets();
    return handler.next(options);
  }
}

Future<String> getSecrets() async {
  final data = await s.rootBundle.loadString('secrets.yaml');
  final mapData = loadYaml(data);
  return mapData["API_KEY"];
}
