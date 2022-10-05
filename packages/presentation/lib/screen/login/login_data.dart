class LoginData {
  final String login;
  final String password;

  LoginData(
    this.login,
    this.password,
  );

  LoginData copyWith({
    String? login,
    String? password,
  }) {
    return LoginData(
      login ?? this.login,
      password ?? this.password,
    );
  }
}
