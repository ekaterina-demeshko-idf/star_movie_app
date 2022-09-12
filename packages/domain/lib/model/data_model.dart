import 'package:domain/model/movie_trending_response.dart';

class GetDataResponse {
  final Map<String, dynamic> headers;
  final List<dynamic> body;

  GetDataResponse({
    required this.headers,
    required this.body,
  });
}
