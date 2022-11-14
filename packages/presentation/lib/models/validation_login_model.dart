import 'package:domain/enum/validation_error_type.dart';

class ValidationLoginModel {
  final ValidationErrorType? email;
  final ValidationErrorType? password;

  ValidationLoginModel(
    this.email,
    this.password,
  );
}
