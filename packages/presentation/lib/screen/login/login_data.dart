class LoginData {
  String? loginValidation;
  String? passwordValidation;

  LoginData({
    this.loginValidation,
    this.passwordValidation,
  });

  factory LoginData.init() => LoginData(
        loginValidation: 'no',
        passwordValidation: 'no',
      );

  LoginData copy() => LoginData(
        loginValidation: loginValidation,
        passwordValidation: passwordValidation,
      );

  LoginData copyWith({
    String? loginValidation,
    String? passwordValidation,
  }) =>
      LoginData(
        loginValidation: loginValidation ?? this.loginValidation,
        passwordValidation: passwordValidation ?? this.passwordValidation,
      );
}
