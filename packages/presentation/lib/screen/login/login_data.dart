import 'package:domain/enum/validation_error_type.dart';

class LoginData {
  ValidationErrorType? loginValidation;
  ValidationErrorType? passwordValidation;

  LoginData({
    this.loginValidation,
    this.passwordValidation,
  });

  factory LoginData.init() => LoginData(
        loginValidation: null,
        passwordValidation: null,
      );

  LoginData copy() => LoginData(
        loginValidation: loginValidation,
        passwordValidation: passwordValidation,
      );

  LoginData copyWith({
    ValidationErrorType? loginValidation,
    ValidationErrorType? passwordValidation,
  }) =>
      LoginData(
        loginValidation: loginValidation ?? this.loginValidation,
        passwordValidation: passwordValidation ?? this.passwordValidation,
      );
}
