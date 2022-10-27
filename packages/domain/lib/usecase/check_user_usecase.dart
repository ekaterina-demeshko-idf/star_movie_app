import 'package:domain/repository/remote_db_repository.dart';
import 'package:domain/usecase/usecase.dart';
import 'package:domain/validator/validation_error.dart';
import '../model/user/user_model.dart';

class CheckUserUseCase implements UseCaseParams<UserModel, Future<void>> {
  final RemoteDBRepository _firestoreRepository;

  CheckUserUseCase(this._firestoreRepository);

  @override
  Future<void> call(UserModel user) async {
    if (!(await _firestoreRepository.checkUserExist(user))) {
      throw ValidationErrors();
    }
  }
}
