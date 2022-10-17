import 'package:domain/validator/validator.dart';

abstract class UseCase<Output> {
  Output call();
}

abstract class UseCaseParams<Params, Output> {
  Output call(Params params);
}

abstract class BaseValidationUseCase<Params, Output> implements UseCaseParams<Params, Output> {
  @override
  Output call(Params params);

  TypeError? getEnumByValidator(Validator v) {
    if (v is RequiredField) {
      return TypeError.requiredTypeError;
    }
    if (v is MinLength) {
      return TypeError.minLengthTypeError;
    }
    if (v is RegEx) {
      return TypeError.regexTypeError;
    }
    return null;
  }
}
