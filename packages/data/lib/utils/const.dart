class Config {
  Config._();

  static const sendTimeout = 15000;
  static const receiveTimeout = 15000;
  static const connectTimeout = 15000;
  static const traktApiKey = 'trakt-api-key';
  static const tmdbApiKey = "TMDB_API_KEY";
  static const apiAnticipatedPath = '/movies/anticipated';
  static const apiTrendingPath = '/movies/trending';
  static const apiMoviesPath = '/movies/';
  static const peoplesEndpoint = '/people';
  static const tmdbBasePath = 'https://api.themoviedb.org';
  static const tmdbPersonPath = '/3/person';
  static const userFirestoreCollection = 'users';
}
