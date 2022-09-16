import '../utils/const.dart';
import 'package:domain/model/movie_trending_response.dart';
import '../repository/movie_repository.dart';
import 'usecase.dart';

class GetMovieTrendingResponseUseCase
    implements UseCase<Future<List<MovieTrendingResponse>>> {
  final NetworkRepository _repository;

  GetMovieTrendingResponseUseCase(this._repository);

  @override
  Future<List<MovieTrendingResponse>> call() async {
    final List<MovieTrendingResponse> jsonMovies = [];
    final response = await _repository.getMovieData(
      apiPath: Config.apiTrendingPath,
      queryParameters: {
        'extended': 'full',
        'page': 1,
      },
    );
    final pageCount = int.parse(response.headers[Config.pageCount][0]);
    if (pageCount >= 5) {
      const int itemCount = 50;
      await _getMovies(itemCount, jsonMovies);
    } else {
      final itemCount = int.parse(response.headers[Config.itemCount][0]);
      await _getMovies(itemCount, jsonMovies);
    }
    return jsonMovies;
  }

  Future<List<MovieTrendingResponse>> _getMovies( //
    int itemCount,
    List<MovieTrendingResponse> jsonMovies,
  ) async {
    final response = await _repository
        .getMovieData(apiPath: Config.apiTrendingPath, queryParameters: {
      'extended': 'full',
      'page': 1,
      'limit': itemCount,
    });
    jsonMovies
        .addAll(response.body.map((e) => MovieTrendingResponse.fromJson(e)));
    return jsonMovies;
  }
}
