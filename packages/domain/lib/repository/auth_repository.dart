import 'package:domain/model/user/user_model.dart';

abstract class AuthRepository {
  Future<UserModel?> authWithFacebook();
  Future<UserModel?> authWithGoogle();
}
