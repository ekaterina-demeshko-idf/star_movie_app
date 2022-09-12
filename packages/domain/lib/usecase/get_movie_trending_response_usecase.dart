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
    final response = await _repository.getMovieData(apiPath: C.apiCorrectPath);
    if (int.parse(response.headers['x-pagination-page-count'][0]) >= 5) {
      int itemCount = 50;
      final response1 = await _repository.getMovieData(
        apiPath: C.apiCorrectPath,
        itemCount: itemCount,
      );
      jsonMovies
          .addAll(response1.body.map((e) => MovieTrendingResponse.fromJson(e)));
    } else {
      final itemCount =
          int.parse(response.headers['x-pagination-item-count'][0]);
      final response1 = await _repository.getMovieData(
        apiPath: C.apiCorrectPath,
        itemCount: itemCount,
      );
      jsonMovies
          .addAll(response1.body.map((e) => MovieTrendingResponse.fromJson(e)));
    }
    return jsonMovies;
  }
}
