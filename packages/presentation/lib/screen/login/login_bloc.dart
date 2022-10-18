import 'package:flutter/material.dart';
import 'package:domain/enum/validation_error_type.dart';
import 'package:domain/model/login_validation_model.dart';
import 'package:domain/model/user/user_model.dart';
import 'package:domain/utils/extensions/string_extension.dart';
import 'package:domain/usecase/check_user_usecase.dart';
import 'package:domain/usecase/google_auth_usecase.dart';
import 'package:domain/usecase/facebook_auth_usecase.dart';
import 'package:domain/usecase/save_credentials_usecase.dart';
import 'package:domain/usecase/login_validation_usecase.dart';
import 'package:presentation/base/bloc.dart';
import 'package:presentation/models/validation_model.dart';
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

  ValidationModel? get validationModel;

  Future<void> onLogin();

  void onChangedTextForm();

  Future<void> authByGoogle();

  Future<void> authByFacebook();
}

class _LoginBloc extends BlocImpl<LoginScreenArguments, LoginData>
    implements LoginBloc {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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
  ValidationModel? validationModel;

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
    validationModel = ValidationModel(
      validationResponse?.emailValidation,
      validationResponse?.passwordValidation,
    );
    if (_formKey.currentState?.validate() ?? false) {
      bool isSuccess = await _checkUserUseCase(user);
      if (!isSuccess) {
        validationModel = ValidationModel(
          ValidationErrorType.invalidValue,
          ValidationErrorType.invalidValue,
        );
        _formKey.currentState?.validate();
      } else {
        await _saveCredentialsUseCase(user);
        _pushSuccessScreen();
      }
    }
  }

  @override
  void onChangedTextForm() {
    validationModel = ValidationModel(
      null,
      null,
    );
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
