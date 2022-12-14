import 'package:domain/model/user/user_model.dart';
import 'package:domain/repository/local_storage_repository.dart';
import 'package:domain/usecase/usecase.dart';
import 'package:domain/utils/extensions/string_extension.dart';

class SaveCredentialsUseCase implements UseCaseParams<UserModel, Future<void>> {
  final LocalStorageRepository _localStorageRepository;

  SaveCredentialsUseCase(this._localStorageRepository);

  @override
  Future<void> call(UserModel params) =>
      _localStorageRepository.saveCredentials(
        params.email.orEmpty,
        params.password.orEmpty,
      );
}
