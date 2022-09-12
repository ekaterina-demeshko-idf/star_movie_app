import 'package:data/service/service_payload.dart';
import 'package:dio/dio.dart';

abstract class ApiBaseService<P extends ServicePayload> {
  Future<Response<T>> get<T>(
    String path, {
    bool isResponseBytes,
    Map<String, dynamic> queryParameters,
    P? payload,
  });

  Future<Response<T>> post<T>(
    String path, {
    bool isResponseBytes,
    dynamic data,
    Map<String, dynamic> queryParameters,
    P? payload,
  });
}

class ApiServiceImpl implements ApiBaseService<DioServicePayload> {
  final Dio _dio;

  ApiServiceImpl(this._dio);

  @override
  Future<Response<T>> get<T>(
    String path, {
    bool isResponseBytes = false,
    Map<String, dynamic>? queryParameters,
    DioServicePayload? payload,
  }) async {
    final response = _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: payload?.options,
      cancelToken: payload?.cancelToken,
      onReceiveProgress: payload?.onReceiveProgress,
    );

    return response;
  }

  @override
  Future<Response<T>> post<T>(
    String path, {
    bool isResponseBytes = false,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    DioServicePayload? payload,
  }) async {
    final response = _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: payload?.options,
      cancelToken: payload?.cancelToken,
      onSendProgress: payload?.onSendProgress,
      onReceiveProgress: payload?.onReceiveProgress,
    );

    return response as Future<Response<T>>;
  }
}
