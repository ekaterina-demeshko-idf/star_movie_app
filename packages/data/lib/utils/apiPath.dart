import 'dart:core';
import 'const.dart';

class ApiPath {
  static String getCastImageFilePath(int tmdbId) {
    return '${Config.tmdbPersonPath}/$tmdbId/images';
  }

  static String getCastDataPath(int traktId) {
    return '${Config.apiMoviesPath}$traktId/people';
  }
}
