import 'package:domain/enum/validation_error_type.dart';
import 'package:domain/model/login_validation_model.dart';
import 'package:domain/model/user/user_model.dart';
import 'package:domain/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:presentation/base/bloc.dart';
import 'package:domain/usecase/check_user_usecase.dart';
import 'package:domain/usecase/google_auth_usecase.dart';
import 'package:domain/usecase/facebook_auth_usecase.dart';
import 'package:domain/usecase/save_credentials_usecase.dart';
import 'package:domain/usecase/login_validation_usecase.dart';
import '../../utils/events.dart';
import '../profile/profile_screen.dart';
import 'login_data.dart';
import 'login_screen.dart';

abstract class LoginBloc extends Bloc<LoginScreenArguments, LoginData> {
  factory LoginBloc(
    CheckUserUseCase checkUserUseCase,
    GoogleAuthUseCase googleAuthUseCase,
    FacebookAuthUseCase facebookAuthUseCase,
    SaveCredentialsUseCase saveCredentialsUseCase,
    LoginValidationUseCase loginValidationUseCase,
  ) =>
      _LoginBloc(
        checkUserUseCase,
        googleAuthUseCase,
        facebookAuthUseCase,
        saveCredentialsUseCase,
        loginValidationUseCase,
      );

  TextEditingController get emailController;

  GlobalKey<FormState> get formKey;

  TextEditingController get passwordController;

  ValidationErrorType? get emailValidation;

  ValidationErrorType? get passwordValidation;

  Future<void> onLogin();

  Future<void> authByGoogle();

  Future<void> authByFacebook();
}

class _LoginBloc extends BlocImpl<LoginScreenArguments, LoginData>
    implements LoginBloc {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  ValidationErrorType? emailValidation;
  @override
  ValidationErrorType? passwordValidation;
  final _formKey = GlobalKey<FormState>();
  final CheckUserUseCase _checkUserUseCase;
  final GoogleAuthUseCase _googleAuthUseCase;
  final FacebookAuthUseCase _facebookAuthUseCase;
  final SaveCredentialsUseCase _saveCredentialsUseCase;
  final LoginValidationUseCase _loginValidationUseCase;

  _LoginBloc(
    this._checkUserUseCase,
    this._googleAuthUseCase,
    this._facebookAuthUseCase,
    this._saveCredentialsUseCase,
    this._loginValidationUseCase,
  );

  @override
  Future<void> onLogin() async {
    await logAnalyticsEventUseCase(AnalyticsEventType.authByLogin);
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final UserModel user = UserModel(email, password);
    final LoginValidationModel? validationResponse =
        _loginValidationUseCase(user);
    emailValidation = validationResponse?.emailValidation;
    passwordValidation = validationResponse?.passwordValidation;
    _formKey.currentState!.validate();
    await _saveCredentialsUseCase(user);
    bool isSuccess = await _checkUserUseCase(user);
    if (isSuccess) {
      _pushSuccessScreen();
    }
  }

  @override
  Future<void> authByGoogle() async {
    await logAnalyticsEventUseCase(AnalyticsEventType.authByGoogle);
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
      _pushSuccessScreen();
    }
  }

  @override
  Future<void> authByFacebook() async {
    await logAnalyticsEventUseCase(AnalyticsEventType.authByFacebook);
    final UserModel user = await _facebookAuthUseCase();
    _emailController.text = user.email.orEmpty;
    _passwordController.text = user.password.orEmpty;
    UserModel userModel = UserModel(
      user.email.orEmpty,
      user.password.orEmpty,
    );
    bool isSuccess = await _checkUserUseCase(userModel);
    if (isSuccess) {
      _pushSuccessScreen();
    }
  }

  void _pushSuccessScreen() {
    appNavigator.push(
      ProfileScreen.page(),
    );
  }

  @override
  TextEditingController get emailController => _emailController;

  @override
  TextEditingController get passwordController => _passwordController;

  @override
  GlobalKey<FormState> get formKey => _formKey;
}
