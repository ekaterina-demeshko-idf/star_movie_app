import '../enum/movie_type.dart';
import '../utils/const.dart';
import '../model/movie/movie_response_model.dart';
import '../repository/trakt_api_repository.dart';
import 'usecase.dart';

class GetMovieListUseCase
    implements UseCaseParams<MovieType, Future<List<MovieResponse>>> {
  final TraktAPIRepository _repository;

  GetMovieListUseCase(this._repository);

  @override
  Future<List<MovieResponse>> call(MovieType movieType) async {
    final List<MovieResponse> jsonMovies = [];
    final response = movieType == MovieType.anticipated
        ? await _repository.getMovieAnticipatedData()
        : await _repository.getMovieTrendingData();
    final pageCount = int.parse(response.headers[Config.pageCount][0]);
    final itemCount =
        pageCount >= 5 ? 50 : int.parse(response.headers[Config.itemCount][0]);
    await _getMovies(itemCount, jsonMovies, movieType);
    return jsonMovies;
  }

  Future<List<MovieResponse>> _getMovies(
    int itemCount,
    List<MovieResponse> jsonMovies,
    MovieType movieType,
  ) async {
    final response = (movieType == MovieType.anticipated)
        ? await _repository.getMovieAnticipatedData(itemCount: itemCount)
        : await _repository.getMovieTrendingData(itemCount: itemCount);
    jsonMovies.addAll(response.body.map((e) => MovieResponse.fromJson(e)));
    return jsonMovies;
  }
}
