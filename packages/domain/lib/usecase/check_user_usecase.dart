import 'package:domain/repository/remote_db_repository.dart';
import 'package:domain/usecase/usecase.dart';
import 'package:domain/validator/validation_login_error.dart';
import '../enum/validation_error_type.dart';
import '../model/user/user_model.dart';

class CheckUserUseCase implements UseCaseParams<UserModel, Future<void>> {
  final RemoteDBRepository _firestoreRepository;

  CheckUserUseCase(this._firestoreRepository);

  @override
  Future<void> call(UserModel user) async {
    final bool isUserExist = await _firestoreRepository.checkUserExist(user);
    if (!isUserExist) {
      throw ValidationLoginErrors(
        emailError: ValidationErrorType.invalidValue,
        passwordError: ValidationErrorType.invalidValue,
      );
    }
  }
}
