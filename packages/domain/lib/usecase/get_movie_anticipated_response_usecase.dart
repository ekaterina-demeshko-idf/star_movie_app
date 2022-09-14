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
    final response =
        await _repository.getMovieData(apiPath: C.apiAnticipatedPath);
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

  Future<List<MovieAnticipatedResponse>> _addToJsonMovies(
    int itemCount,
    List<MovieAnticipatedResponse> jsonMovies,
  ) async {
    final response = await _repository.getMovieData(
      apiPath: C.apiAnticipatedPath,
      itemCount: itemCount,
    );
    jsonMovies
        .addAll(response.body.map((e) => MovieAnticipatedResponse.fromJson(e)));
    return jsonMovies;
  }
}
