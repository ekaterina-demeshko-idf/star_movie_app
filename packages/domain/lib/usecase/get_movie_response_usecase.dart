// import '../utils/const.dart';
// import '../model/movie_anticipated_response.dart';
// import '../repository/movie_repository.dart';
// import 'usecase.dart';
//
// enum MovieType {
//   anticipated,
//   trending,
// }
//
// class GetMovieAnticipatedResponseUseCase
//     implements UseCase<Future<List<MovieAnticipatedResponse>>> {
//   final NetworkRepository _repository;
//
//   GetMovieAnticipatedResponseUseCase(this._repository);
//
//   @override
//   Future<List<MovieResponse>> call(movieType) async {
//     final List<MovieResponse> jsonMovies = [];
//     final response = movieType == Antipa ? rep1 : rep2;
//     // final response = await _repository.getMovieData(
//     //   apiPath: Config.apiAnticipatedPath,
//     //   queryParameters: {
//     //     'extended': 'full',
//     //     'page': 1,
//     //   },
//     // );
//     final pageCount = int.parse(response.headers[Config.pageCount][0]);
//     if (pageCount >= 5) {
//       const int itemCount = 50;
//       await _getMovies(itemCount, jsonMovies);
//     } else {
//       final itemCount = int.parse(response.headers[Config.itemCount][0]);
//       await _getMovies(itemCount, jsonMovies);
//     }
//     return jsonMovies;
//   }
//
//   Future<List<MovieAnticipatedResponse>> _getMovies(
//     int itemCount,
//     List<MovieAnticipatedResponse> jsonMovies,
//   ) async {
//     final response = await _repository.getMovieData(
//       apiPath: Config.apiAnticipatedPath,
//       queryParameters: {
//         'extended': 'full',
//         'page': 1,
//         'limit': itemCount,
//       },
//     );
//     jsonMovies
//         .addAll(response.body.map((e) => MovieAnticipatedResponse.fromJson(e)));
//     return jsonMovies;
//   }
// }
