abstract class LocalStorageRepository {
  Future<void> saveCredentials(String email, String password);
}