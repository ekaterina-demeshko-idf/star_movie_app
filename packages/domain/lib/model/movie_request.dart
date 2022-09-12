import 'package:domain/model/base_request.dart';

class MovieRequest implements BaseRequest {
  final int value;

  MovieRequest(this.value);

  @override
  Map<String, dynamic> toMap() => {};
}
