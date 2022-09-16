import '../enum/movie_type.dart';
import '../utils/const.dart';
import '../model/movie_response_model.dart';
import '../repository/movie_repository.dart';
import 'usecase.dart';

class GetMovieResponseUseCase
    implements UseCaseParams<MovieType, Future<List<MovieResponse>>> {
  final NetworkRepository _repository;

  GetMovieResponseUseCase(this._repository);

  @override
  Future<List<MovieResponse>> call(movieType) async {
    final List<MovieResponse> jsonMovies = [];
    final response = (movieType == MovieType.anticipated)
        ? await _repository.getMovieAnticipatedData(
            queryParameters: {
              'extended': 'full',
              'page': 1,
            },
          )
        : await _repository.getMovieTrendingData(
            queryParameters: {
              'extended': 'full',
              'page': 1,
            },
          );
    final pageCount = int.parse(response.headers[Config.pageCount][0]);
    if (pageCount >= 5) {
      const int itemCount = 50;
      await _getMovies(itemCount, jsonMovies, movieType);
    } else {
      final itemCount = int.parse(response.headers[Config.itemCount][0]);
      await _getMovies(itemCount, jsonMovies, movieType);
    }
    return jsonMovies;
  }

  Future<List<MovieResponse>> _getMovies(
      int itemCount, List<MovieResponse> jsonMovies, movieType) async {
    final response = (movieType == MovieType.anticipated)
        ? await _repository.getMovieAnticipatedData(
            queryParameters: {
              'extended': 'full',
              'page': 1,
              'limit': itemCount,
            },
          )
        : await _repository.getMovieTrendingData(
            queryParameters: {
              'extended': 'full',
              'page': 1,
              'limit': itemCount,
            },
          );
    jsonMovies.addAll(response.body.map((e) => MovieResponse.fromJson(e)));
    return jsonMovies;
  }
}
