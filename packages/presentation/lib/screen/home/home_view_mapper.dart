import 'package:domain/model/movie_response_model.dart';
import 'package:domain/utils/extensions/string_extension.dart';
import 'package:domain/utils/extensions/int_extension.dart';
import 'package:domain/utils/getSecrets.dart';
import 'package:yaml/yaml.dart';
import 'movie_model.dart';

abstract class HomeViewMapper {
  factory HomeViewMapper() => _HomeViewMapper();

  Future<List<MoviePresentation>> mapMovieDataToRequest(
      List<MovieResponse> response);
}

class _HomeViewMapper implements HomeViewMapper {
  @override
  Future<List<MoviePresentation>> mapMovieDataToRequest(
    List<MovieResponse> response,
  ) async {
    String key = await getImageSecret();
    return response
        .map((e) => MoviePresentation(
              e.movie.title.orEmpty,
              'http://img.omdbapi.com/?apikey=$key&i=${e.movie.ids?.imdb}',
              e.movie.runtime.convertTimeToString,
              (e.movie.rating ?? 0.0) / 2,
              e.movie.genres?.first.orEmpty.capitalize,
              e.movie.certification.toString(),
            ))
        .toList();
  }

  Future<String> getImageSecret() async {
    YamlMap secrets = await getSecrets();
    return secrets["IMG_API_KEY"];
  }
}
