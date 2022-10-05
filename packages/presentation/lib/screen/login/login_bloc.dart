import 'package:domain/model/user/user_model.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:presentation/base/bloc.dart';
import 'package:domain/usecase/check_user_usecase.dart';
import 'package:domain/usecase/google_auth_usecase.dart';
import 'package:domain/usecase/facebook_auth_usecase.dart';
import 'package:domain/usecase/analytics_usecase.dart';
import '../profile/profile_screen.dart';
import 'login_data.dart';
import 'login_screen.dart';

abstract class LoginBloc extends Bloc<LoginScreenArguments, LoginData> {
  factory LoginBloc(
    CheckUserUseCase checkUserUseCase,
    GoogleAuthUseCase googleAuthUseCase,
    FacebookAuthUseCase facebookAuthUseCase,
    AnalyticsUseCase analyticsUseCase,
  ) =>
      _LoginBloc(
        checkUserUseCase,
        googleAuthUseCase,
        facebookAuthUseCase,
        analyticsUseCase,
      );

  TextEditingController get emailController;

  TextEditingController get passwordController;

  Future<void> onLogin();

  Future<void> authByGoogle();

  Future<void> authByFacebook();
}

class _LoginBloc extends BlocImpl<LoginScreenArguments, LoginData>
    implements LoginBloc {
  LoginData _screenData = LoginData(
    '',
    '',
  );
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final CheckUserUseCase _checkUserUseCase;
  final GoogleAuthUseCase _googleAuthUseCase;
  final FacebookAuthUseCase _facebookAuthUseCase;
  final AnalyticsUseCase _analyticsUseCase;

  _LoginBloc(
    this._checkUserUseCase,
    this._googleAuthUseCase,
    this._facebookAuthUseCase,
    this._analyticsUseCase,
  );

  @override
  void initArgs(LoginScreenArguments arguments) {
    super.initArgs(arguments);
    _screenData = LoginData(
      '',
      '',
    );
    _updateData();
  }

  _updateData({bool? isLoading}) {
    handleData(
      data: _screenData,
      isLoading: isLoading,
    );
  }

  @override
  Future<void> onLogin() async {
    await _analyticsUseCase('auth_by_login');
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    UserModel user = UserModel(email, password);
    final bool isSuccess = await _checkUserUseCase(user);
    if (isSuccess) {
      appNavigator.push(
        ProfileScreen.page(),
      );
    }
  }

  @override
  Future<void> authByGoogle() async {
    await _analyticsUseCase('auth_by_google');
    final bool isSuccess = await _googleAuthUseCase();
    if (isSuccess) {
      appNavigator.push(
        ProfileScreen.page(),
      );
    }
  }

  @override
  Future<void> authByFacebook() async {
    await _analyticsUseCase('auth_by_fb');
    final bool isSuccess = await _facebookAuthUseCase();
    if (isSuccess) {
      appNavigator.push(
        ProfileScreen.page(),
      );
    }
  }

  @override
  TextEditingController get emailController => _emailController;

  @override
  TextEditingController get passwordController => _passwordController;
}
