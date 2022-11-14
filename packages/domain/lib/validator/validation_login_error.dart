import 'package:domain/enum/validation_error_type.dart';

class BaseException implements Exception {}

class ValidationLoginErrors extends BaseException {
  ValidationErrorType? emailError;
  ValidationErrorType? passwordError;

  ValidationLoginErrors({
    required this.emailError,
    required this.passwordError,
  });
}
