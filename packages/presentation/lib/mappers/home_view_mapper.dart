import 'package:domain/model/cache_models/movie_cache_model.dart';
import 'package:domain/utils/extensions/int_extension.dart';
import 'package:domain/utils/extensions/list_extension.dart';
import 'package:domain/utils/extensions/string_extension.dart';
import 'package:domain/utils/getSecrets.dart';
import 'package:yaml/yaml.dart';
import '../models/movie_model.dart';

abstract class HomeViewMapper {
  factory HomeViewMapper() => _HomeViewMapper();

  Future<List<MoviePresentation>> mapMovieDataToRequest(
      List<MovieCache> response);
}

class _HomeViewMapper implements HomeViewMapper {
  late YamlMap secrets;

  _HomeViewMapper() {
    getAsyncSecrets();
  }

  @override
  Future<List<MoviePresentation>> mapMovieDataToRequest(
    List<MovieCache> response,
  ) async {
    String key = secrets["IMG_API_KEY"];
    return response
        .map((e) => MoviePresentation(
              e.title.orEmpty,
              'http://img.omdbapi.com/?apikey=$key&i=${e.imdb}',
              e.runtime.convertTimeToString,
              (e.rating ?? 0.0) / 2,
              e.genres?.first.orEmpty.capitalize,
              cutToThree(e.genres?.orEmpty),
              e.certification.toString(),
              e.overview?.orEmpty,
              e.trakt,
              e.tmdb,
            ))
        .toList();
  }

  List capitalizeList(List<String> list) {
    List newList = [];
    for (var s in list) {
      newList.add(s[0].toUpperCase() + s.substring(1).toLowerCase());
    }
    return newList;
  }

  String cutToThree(List<String>? list) {
    if (list == null) {
      return 'No info';
    } else {
      if (list.length > 3) {
        list.length = 3;
        return capitalizeList(list).join(', ');
      } else {
        return capitalizeList(list).join(', ');
      }
    }
  }

  void getAsyncSecrets() async {
    secrets = await getSecrets();
  }
}
