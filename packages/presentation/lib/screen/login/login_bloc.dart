import 'package:presentation/base/bloc.dart';
import 'login_data.dart';
import 'login_screen.dart';

abstract class LoginBloc extends Bloc<LoginScreenArguments, LoginData> {
  factory LoginBloc() => _LoginBloc();

  Future<void> onLogin();
}

class _LoginBloc extends BlocImpl<LoginScreenArguments, LoginData>
    implements LoginBloc {
  _LoginBloc();

  // @override
  // void initArgs(LoginScreenArguments arguments) {
  //   super.initArgs(arguments);
  //   _screenData = LoginData();
  //   _updateData();
  // }

  @override
  Future<void> onLogin() async {
  _updateData();
  }


  _updateData({bool? isLoading}) {
    handleData(
      isLoading: isLoading,
    );
  }
}
