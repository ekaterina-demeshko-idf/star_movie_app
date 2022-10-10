import 'package:domain/model/user/user_model.dart';
import 'package:domain/model/user/user_facebook_model.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:domain/repository/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl implements AuthRepository {
  final GoogleSignIn _authGoogleProvider;
  final FacebookAuth _authFBProvider;

  AuthRepositoryImpl(
    this._authGoogleProvider,
    this._authFBProvider,
  );

  Future<UserFacebookModel> loginFacebook() async {
    final loginResult = await _authFBProvider.login();
    if (loginResult.status == LoginStatus.success) {
      final UserFacebookModel userFacebookModel =
          UserFacebookModel.fromJson(await _authFBProvider.getUserData());
      return userFacebookModel;
    }
    throw Exception('Not authorized');
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
    throw Exception('Not authorized');
  }

  @override
  Future<UserModel> authWithFacebook() async {
    final UserFacebookModel userData = await loginFacebook();
    if (userData != null) {
      return UserModel.fromFacebook(userData);
    }
    throw Exception('Not authorized');
  }

  @override
  Future<UserModel> authWithGoogle() async {
    final userData = await loginGoogle();
    if (userData != null) {
      return UserModel.fromJson(userData);
    }
    throw Exception('Not authorized');
  }
}
