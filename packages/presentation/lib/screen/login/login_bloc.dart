import 'package:presentation/base/bloc.dart';
import 'login_data.dart';
import 'login_screen.dart';

abstract class LoginBloc extends Bloc<LoginScreenArguments, LoginData> {
  factory LoginBloc() => _LoginBloc();
}

class _LoginBloc extends BlocImpl<LoginScreenArguments, LoginData>
    implements LoginBloc {
  LoginData _screenData = LoginData();

  _LoginBloc();

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
}
