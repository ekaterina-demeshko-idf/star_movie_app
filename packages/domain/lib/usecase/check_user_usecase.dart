import 'package:domain/repository/remote_db_repository.dart';
import 'package:domain/usecase/usecase.dart';
import '../model/user/user_model.dart';

class CheckUserUseCase implements UseCaseParams<UserModel, Future<bool>> {
  final RemoteDBRepository _firestoreRepository;

  CheckUserUseCase(this._firestoreRepository);

  @override
  Future<bool> call(UserModel user) async =>
      _firestoreRepository.checkUserExist(user);
}
