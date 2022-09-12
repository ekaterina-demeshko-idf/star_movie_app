import 'package:data/interceptor/secrets.dart';
import 'package:dio/dio.dart';

class MyInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['trakt-api-key'] = Secrets.API_KEY;
    return handler.next(options);
  }

}
