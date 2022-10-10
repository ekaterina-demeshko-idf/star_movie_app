import 'package:domain/model/user/user_model.dart';
import 'package:domain/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:presentation/base/bloc.dart';
import 'package:domain/usecase/check_user_usecase.dart';
import 'package:domain/usecase/google_auth_usecase.dart';
import 'package:domain/usecase/facebook_auth_usecase.dart';
import 'package:domain/usecase/analytics_usecase.dart';
import 'package:domain/usecase/save_credentials_usecase.dart';
import '../profile/profile_screen.dart';
import 'login_data.dart';
import 'login_screen.dart';

abstract class LoginBloc extends Bloc<LoginScreenArguments, LoginData> {
  factory LoginBloc(
    CheckUserUseCase checkUserUseCase,
    GoogleAuthUseCase googleAuthUseCase,
    FacebookAuthUseCase facebookAuthUseCase,
    LogAnalyticsEventUseCase logAnalyticsEventUseCase,
    SaveCredentialsUseCase saveCredentialsUseCase,
  ) =>
      _LoginBloc(
        checkUserUseCase,
        googleAuthUseCase,
        facebookAuthUseCase,
        logAnalyticsEventUseCase,
        saveCredentialsUseCase,
      );

  TextEditingController get emailController;

  TextEditingController get passwordController;

  Future<void> onLogin();

  Future<void> authByGoogle();

  Future<void> authByFacebook();
}

class _LoginBloc extends BlocImpl<LoginScreenArguments, LoginData>
    implements LoginBloc {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final CheckUserUseCase _checkUserUseCase;
  final GoogleAuthUseCase _googleAuthUseCase;
  final FacebookAuthUseCase _facebookAuthUseCase;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;
  final SaveCredentialsUseCase _saveCredentialsUseCase;

  _LoginBloc(
    this._checkUserUseCase,
    this._googleAuthUseCase,
    this._facebookAuthUseCase,
    this._logAnalyticsEventUseCase,
    this._saveCredentialsUseCase,
  );

  @override
  Future<void> onLogin() async {
    await _logAnalyticsEventUseCase('auth_by_login');
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final UserModel user = UserModel(email, password);
    await _saveCredentialsUseCase(user);
    bool isSuccess = await _checkUserUseCase(user);
    if (isSuccess) {
      pushSuccessScreen();
    }
  }

  @override
  Future<void> authByGoogle() async {
    await _logAnalyticsEventUseCase('auth_by_google');
    final UserModel user = await _googleAuthUseCase();
    _emailController.text = user.email.orEmpty;
    _passwordController.text = user.password.orEmpty;
    UserModel userModel = UserModel(
      user.email.orEmpty,
      user.password.orEmpty,
    );
    await _saveCredentialsUseCase(userModel);
    bool isSuccess = await _checkUserUseCase(userModel);
    if (isSuccess) {
      pushSuccessScreen();
    }
  }

  @override
  Future<void> authByFacebook() async {
    await _logAnalyticsEventUseCase('auth_by_fb');
    final UserModel user = await _facebookAuthUseCase();
    _emailController.text = user.email.orEmpty;
    _passwordController.text = user.password.orEmpty;
    UserModel userModel = UserModel(
      user.email.orEmpty,
      user.password.orEmpty,
    );
    bool isSuccess = await _checkUserUseCase(userModel);
    if (isSuccess) {
      pushSuccessScreen();
    }
  }

  void pushSuccessScreen() {
    appNavigator.push(
      ProfileScreen.page(),
    );
  }

  @override
  TextEditingController get emailController => _emailController;

  @override
  TextEditingController get passwordController => _passwordController;
}
