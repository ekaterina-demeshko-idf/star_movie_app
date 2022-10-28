import 'package:domain/validator/validator.dart';
import 'package:domain/enum/validation_error_type.dart';

abstract class UseCase<Output> {
  Output call();
}

abstract class UseCaseParams<Params, Output> {
  Output call(Params params);
}

abstract class BaseValidationUseCase<Params, Output>
    implements UseCaseParams<Params, Output> {
  ValidationErrorType? getEnumByValidator(Validator? v) {
    if (v is RequiredField) {
      return ValidationErrorType.requiredTypeError;
    }
    if (v is MinLength) {
      return ValidationErrorType.minLengthTypeError;
    }
    if (v is RegEx) {
      return ValidationErrorType.regexTypeError;
    }
    return ValidationErrorType.invalidValue;
  }
}
