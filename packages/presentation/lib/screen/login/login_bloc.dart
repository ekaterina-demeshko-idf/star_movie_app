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
import 'package:presentation/mappers/error_view_mapper.dart';
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
    ErrorViewMapper errorViewMapper,
  ) =>
      _LoginBloc(
        checkUserUseCase,
        googleAuthUseCase,
        facebookAuthUseCase,
        saveCredentialsUseCase,
        loginValidationUseCase,
        errorViewMapper,
      );

  TextEditingController get emailController;

  GlobalKey<FormState> get formKey;

  TextEditingController get passwordController;

  ValidationErrorType? get emailValidation;

  ValidationErrorType? get passwordValidation;

  Future<void> onLogin();

  void onChanged();

  Future<void> authByGoogle();

  Future<void> authByFacebook();

  ErrorViewMapper get errorViewMapper;
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
  final ErrorViewMapper _errorViewMapper;
  @override
  ErrorViewMapper get errorViewMapper => _errorViewMapper;

  _LoginBloc(
    this._checkUserUseCase,
    this._googleAuthUseCase,
    this._facebookAuthUseCase,
    this._saveCredentialsUseCase,
    this._loginValidationUseCase,
    this._errorViewMapper,
  );

  @override
  TextEditingController get emailController => _emailController;

  @override
  TextEditingController get passwordController => _passwordController;

  @override
  GlobalKey<FormState> get formKey => _formKey;

  @override
  Future<void> onLogin() async {
    await logAnalyticsEventUseCase(AnalyticsEventType.authByLogin);
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final UserModel user = UserModel(email, password);
    final LoginValidationError? validationResponse =
        await _loginValidationUseCase(user);
    emailValidation = validationResponse?.emailValidation;
    passwordValidation = validationResponse?.passwordValidation;
    bool isSuccess = _formKey.currentState?.validate() ?? false;
    if (isSuccess) {
      await _saveCredentialsUseCase(user);
      _pushSuccessScreen();
    }
  }

  @override
  void onChanged() {
    passwordValidation = null;
    emailValidation = null;
    formKey.currentState?.validate();
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
    bool isSuccess = await _checkUserUseCase(userModel);
    if (isSuccess) {
      await _saveCredentialsUseCase(userModel);
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
}
