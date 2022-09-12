import 'package:domain/model/data_model.dart';
import '../service/api_base_service.dart';
import '../service/service_payload.dart';
import 'package:domain/repository/movie_repository.dart';

class NetworkRepositoryImpl implements NetworkRepository {
  final ApiBaseService<ServicePayload> _movieApiService;

  NetworkRepositoryImpl(this._movieApiService);

  @override
  Future<GetDataResponse> getMovieData({required String apiPath, int? itemCount}) async {
    final response = await _movieApiService.get(
      apiPath,
      queryParameters: {
        'extended': 'full',
        'page' : 1,
        'limit': itemCount,
      },

    );

    return GetDataResponse(
      headers: response.headers.map,
      body: (response.data as List<dynamic>)
          .map((e) => e as Map<String, dynamic>).toList(),
          // .map((e) => MovieTrendingResponse.fromJson(e))
          // .toList(),
    );
  }
}
