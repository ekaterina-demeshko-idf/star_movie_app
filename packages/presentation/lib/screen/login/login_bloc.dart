import 'package:domain/model/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:presentation/base/bloc.dart';
import 'package:domain/usecase/check_user_usecase.dart';
import '../profile/profile_screen.dart';
import 'login_data.dart';
import 'login_screen.dart';

abstract class LoginBloc extends Bloc<LoginScreenArguments, LoginData> {
  factory LoginBloc(CheckUserUseCase checkUserUseCase) =>
      _LoginBloc(checkUserUseCase);

  TextEditingController get emailController;

  TextEditingController get passwordController;

  Future<void> onLogin();
}

class _LoginBloc extends BlocImpl<LoginScreenArguments, LoginData>
    implements LoginBloc {
  LoginData _screenData = LoginData();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final CheckUserUseCase _checkUserUseCase;

  _LoginBloc(this._checkUserUseCase);

  @override
  void initArgs(LoginScreenArguments arguments) {
    super.initArgs(arguments);
    _screenData = LoginData();
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
  TextEditingController get emailController => _emailController;

  @override
  TextEditingController get passwordController => _passwordController;
}
