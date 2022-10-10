import 'package:domain/repository/local_storage_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageRepositoryImpl implements LocalStorageRepository {
  final SharedPreferences _preferencesProvider;

  LocalStorageRepositoryImpl(this._preferencesProvider);

  @override
  Future<void> saveCredentials(
      String email,
      String password,
      ) async {
    await _preferencesProvider.setString(
      'email',
      email,
    );
    await _preferencesProvider.setString(
      'password',
      password,
    );
  }
}