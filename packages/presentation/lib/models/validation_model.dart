import 'package:domain/enum/validation_error_type.dart';

class ValidationModel {
  ValidationErrorType? email;
  ValidationErrorType? password;

  ValidationModel(
    this.email,
    this.password,
  );
}
