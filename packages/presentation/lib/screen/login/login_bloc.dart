import 'package:domain/model/user/user_model.dart';
import 'package:domain/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:presentation/base/bloc.dart';
import 'package:domain/usecase/check_user_usecase.dart';
import 'package:domain/usecase/google_auth_usecase.dart';
import 'package:domain/usecase/facebook_auth_usecase.dart';
import 'package:domain/usecase/save_credentials_usecase.dart';
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
  ) =>
      _LoginBloc(
        checkUserUseCase,
        googleAuthUseCase,
        facebookAuthUseCase,
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
  var _screenData = LoginData.init();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final CheckUserUseCase _checkUserUseCase;
  final GoogleAuthUseCase _googleAuthUseCase;
  final FacebookAuthUseCase _facebookAuthUseCase;
  final SaveCredentialsUseCase _saveCredentialsUseCase;

  _LoginBloc(
    this._checkUserUseCase,
    this._googleAuthUseCase,
    this._facebookAuthUseCase,
    this._saveCredentialsUseCase,
  );

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  @override
  Future<void> onLogin() async {
    await logAnalyticsEventUseCase(AnalyticsEventType.authByLogin);
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    //if(valid) { //all the above} else {set login data valid to string(s)}
    _screenData = _screenData.copyWith(
        loginValidation: 'not implemented',
        passwordValidation: 'not implemented');
    final UserModel user = UserModel(email, password);
    await _saveCredentialsUseCase(user);
    print(_screenData.passwordValidation);
    bool isSuccess = await _checkUserUseCase(user);
    _updateData();
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

  _updateData({bool? isLoading}) {
    handleData(
      data: _screenData,
      isLoading: isLoading,
    );
  }

  @override
  TextEditingController get emailController => _emailController;

  @override
  TextEditingController get passwordController => _passwordController;
}
