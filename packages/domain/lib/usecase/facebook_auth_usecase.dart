import 'package:domain/model/user/user_model.dart';
import 'package:domain/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class FacebookAuthUseCase implements UseCase<Future<UserModel?>> {
  final AuthRepository _authService;

  FacebookAuthUseCase(this._authService);

  @override
  Future<UserModel?> call() async {
    return await _authService.authWithFacebook();
  }
}
