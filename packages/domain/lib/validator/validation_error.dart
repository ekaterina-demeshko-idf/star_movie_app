import 'package:domain/enum/validation_error_type.dart';

class BaseException implements Exception {}

class ValidationErrors extends BaseException {
  ValidationErrorType? emailError;
  ValidationErrorType? passwordError;

  ValidationErrors({
    required this.emailError,
    required this.passwordError,
  });
}
