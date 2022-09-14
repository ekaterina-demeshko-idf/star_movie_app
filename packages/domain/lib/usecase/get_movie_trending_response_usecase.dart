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
    final response = await _repository.getMovieData(apiPath: C.apiTrendingPath);
    if (int.parse(response.headers['x-pagination-page-count'][0]) >= 5) {
      const int itemCount = 50;
      await _addToJsonMovies(itemCount, jsonMovies);
    } else {
      final itemCount =
          int.parse(response.headers['x-pagination-item-count'][0]);
      await _addToJsonMovies(itemCount, jsonMovies);
    }
    return jsonMovies;
  }

  Future<List<MovieTrendingResponse>> _addToJsonMovies(
    int itemCount,
    List<MovieTrendingResponse> jsonMovies,
  ) async {
    final response = await _repository.getMovieData(
      apiPath: C.apiTrendingPath,
      itemCount: itemCount,
    );
    jsonMovies
        .addAll(response.body.map((e) => MovieTrendingResponse.fromJson(e)));
    return jsonMovies;
  }
}
