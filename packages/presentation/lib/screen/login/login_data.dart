class LoginData {
  final String _login;
  final String _password;

  LoginData(
    this._login,
    this._password,
  );

  LoginData copyWith({
    String? login,
    String? password,
  }) {
    return LoginData(
      login ?? _login,
      password ?? _password,
    );
  }
}
