abstract class FirestoreRepository {
  Future<bool> checkUserExist(
    String collection,
    Map<String, dynamic>? queryMap,
  );
}
