class Config {
  Config._();
  static const sendTimeout = 15000;
  static const receiveTimeout = 15000;
  static const connectTimeout = 15000;
  static const traktApiKey = 'trakt-api-key';
  static const apiBasePath = 'https://api.trakt.tv';
  static const apiAnticipatedPath = 'https://api.trakt.tv/movies/anticipated';
  static const apiTrendingPath = 'https://api.trakt.tv/movies/trending';
 // static const apiPeoplePath = 'https://api.trakt.tv/movies/id/people';
  static const apiMoviesPath = 'https://api.trakt.tv/movies/';
  static const peoplesEndpoint = '/people';
  static const tmdbPersonPath = 'https://api.themoviedb.org/3/person';
}
