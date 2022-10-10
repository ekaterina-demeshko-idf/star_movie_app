import 'package:domain/model/user/user_model.dart';
import 'package:domain/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class GoogleAuthUseCase implements UseCase<Future<UserModel>> {
  final AuthRepository _authRepository;

  GoogleAuthUseCase(this._authRepository);

  @override
  Future<UserModel> call() async => _authRepository.authWithGoogle();
}
