import '../enum/validation_error_type.dart';

class LoginValidationModel {
  final ValidationErrorType? emailValidation;
  final ValidationErrorType? passwordValidation;

  LoginValidationModel(
    this.emailValidation,
    this.passwordValidation,
  );
}
