import '../utils/const.dart';
import '../model/movie_anticipated_response.dart';
import '../repository/movie_repository.dart';
import 'usecase.dart';

class GetMovieAnticipatedResponseUseCase
    implements UseCase<Future<List<MovieAnticipatedResponse>>> {
  final NetworkRepository _repository;

  GetMovieAnticipatedResponseUseCase(this._repository);

  @override
  Future<List<MovieAnticipatedResponse>> call() async {
    final List<MovieAnticipatedResponse> jsonMovies = [];
    final response = await _repository.getMovieData(
      apiPath: Config.apiAnticipatedPath,
      queryParameters: {
        'extended': 'full',
        'page': 1,
      },
    );
    final pageCount = int.parse(response.headers[Config.pageCount][0]);
    if (pageCount >= 5) {
      const int itemCount = 50;
      await _addToJsonMovies(itemCount, jsonMovies);
    } else {
      final itemCount = int.parse(response.headers[Config.itemCount][0]);
      await _addToJsonMovies(itemCount, jsonMovies);
    }
    return jsonMovies;
  }

  Future<List<MovieAnticipatedResponse>> _addToJsonMovies(
    int itemCount,
    List<MovieAnticipatedResponse> jsonMovies,
  ) async {
    final response = await _repository.getMovieData(
      apiPath: Config.apiAnticipatedPath,
      queryParameters: {
        'extended': 'full',
        'page': 1,
        'limit': itemCount,
      },
    );
    jsonMovies
        .addAll(response.body.map((e) => MovieAnticipatedResponse.fromJson(e)));
    return jsonMovies;
  }
}
