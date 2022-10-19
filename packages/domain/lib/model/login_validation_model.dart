import '../enum/validation_error_type.dart';

class LoginValidationError {
  final ValidationErrorType? emailValidation;
  final ValidationErrorType? passwordValidation;

  LoginValidationError(
    this.emailValidation,
    this.passwordValidation,
  );
}
