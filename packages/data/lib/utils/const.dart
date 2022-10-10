class Config {
  Config._();

  static const sendTimeout = 15000;
  static const receiveTimeout = 15000;
  static const connectTimeout = 15000;
  static const traktApiKey = 'trakt-api-key';
  static const tmdbApiKey = "TMDB_API_KEY";
}

class Firestore {
  Firestore._();

  static const userFirestoreCollection = 'users';
}