import 'dart:core';

class ApiPath {
  static const apiAnticipatedPath = '/movies/anticipated';
  static const apiTrendingPath = '/movies/trending';
  static const apiMoviesPath = '/movies/';
  static const peoplesEndpoint = '/people';
  static const tmdbBasePath = 'https://api.themoviedb.org';
  static const tmdbPersonPath = '/3/person';

  static String getCastImageFilePath(int tmdbId) {
    return '${tmdbPersonPath}/$tmdbId/images';
  }

  static String getCastDataPath(int traktId) {
    return '${apiMoviesPath}$traktId/people';
  }
}
