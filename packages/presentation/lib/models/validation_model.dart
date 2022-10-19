import 'package:domain/enum/validation_error_type.dart';

class ValidationModel {
  final ValidationErrorType? email;
  final ValidationErrorType? password;

  ValidationModel(
    this.email,
    this.password,
  );
}
