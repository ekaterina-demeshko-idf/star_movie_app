import 'package:domain/enum/validation_error_type.dart';

class BaseException implements Exception {}

class ValidationDateErrors extends BaseException {
  ValidationErrorType? dateError;

  ValidationDateErrors({
    required this.dateError,
  });
}
