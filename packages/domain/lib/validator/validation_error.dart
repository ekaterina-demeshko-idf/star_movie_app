import 'package:domain/enum/validation_error_type.dart';

class BaseException implements Exception {}

class ValidationErrors extends BaseException {
  ValidationErrors();
}
