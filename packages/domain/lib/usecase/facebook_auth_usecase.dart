import 'package:domain/model/user/user_model.dart';
import 'package:domain/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class FacebookAuthUseCase implements UseCase<Future<UserModel?>> {
  final AuthRepository _authRepository;

  FacebookAuthUseCase(this._authRepository);

  @override
  Future<UserModel?> call() async => await _authRepository.authWithFacebook();
}
