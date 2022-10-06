import 'package:domain/model/user/user_model.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SharedPreferences _preferences;

  AuthRepositoryImpl(this._preferences);

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
      await _preferences.setString('email', userData['email']);
      await _preferences.setString('password', userData['id']);
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
      await _preferences.setString('email', userData['email']);
      await _preferences.setString('password', userData['password']);
      return UserModel(
        userData['email'],
        userData['password'],
      );
    }
    return null;
  }
}
