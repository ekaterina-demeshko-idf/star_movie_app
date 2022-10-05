import 'package:domain/model/user/user_model.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl();

  final _authFBProvider = FacebookAuth.instance;
  final _authGoogleProvider = GoogleSignIn();

  Future<Map<String, dynamic>?> loginFacebook() async {
    final loginResult = await _authFBProvider.login();
    if (loginResult.status == LoginStatus.success) {
      return await _authFBProvider.getUserData();
    }
    return null;
  }

  Future<Map<String, dynamic>?> loginGoogle() async {
    final loginResult = await _authGoogleProvider.signIn();
    if (loginResult != null) {
      final userData = {
        'email': loginResult.email,
        'password': loginResult.id,
      };
      return userData;
    }
    return null;
  }

  @override
  Future<UserModel?> authWithFacebook() async {
    final userData = await loginFacebook();
    if (userData != null) {
      return UserModel(
        userData['email'],
        userData['id'],
      );
    }
    return null;
  }

  @override
  Future<UserModel?> authWithGoogle() async {
    final userData = await loginGoogle();
    if (userData != null) {
      return UserModel(
        userData['email'],
        userData['password'],
      );
    }
    return null;
  }
}
