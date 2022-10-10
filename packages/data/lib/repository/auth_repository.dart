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

  @override
  Future<UserModel> authWithFacebook() async {
    final loginResult = await _authFBProvider.login();
    if (loginResult.status == LoginStatus.success) {
      final UserFacebookModel userFacebookModel =
          UserFacebookModel.fromJson(await _authFBProvider.getUserData());
      if (userFacebookModel != null) {
        return UserModel.fromFacebook(userFacebookModel);
      }
    }
    throw Exception('Not authorized');
  }

  @override
  Future<UserModel> authWithGoogle() async {
    final loginResult = await _authGoogleProvider.signIn();
    if (loginResult != null) {
      final userData = {
        'email': loginResult.email,
        'password': loginResult.id,
      };
      if (userData != null) {
        return UserModel.fromJson(userData);
      }
    }
    throw Exception('Not authorized');
  }
}
