abstract class FirestoreRepository {
  Future<bool> checkUser(
    String collection,
    Map<String, dynamic>? queryMap,
  );
}
