import 'package:domain/model/login_model.dart';
import 'package:domain/model/login_validation_model.dart';
import 'package:domain/usecase/usecase.dart';
import 'package:domain/validator/validator.dart';
import 'package:domain/enum/validation_error_type.dart';

class LoginValidationUseCase
    extends BaseValidationUseCase<LoginModel, LoginValidationModel?> {
  @override
  LoginValidationModel? call(LoginModel params) {
    const String passwordValidationRegEx = '^[A-Za-z0-9]{7,}\$';

    List emailValidationArr = [
      RequiredField(),
      MinLength(8),
    ];

    List passwordValidationArr = [
      RequiredField(),
      RegEx(passwordValidationRegEx),
    ];

    final Validator emailFailed = emailValidationArr
        .firstWhere((element) => !element.isValid(params.email));

    final ValidationErrorType? emailFailedType =
        getEnumByValidator(emailFailed);

    final Validator passwordFailed = passwordValidationArr
        .firstWhere((element) => !element.isValid(params.password));

    final ValidationErrorType? passwordFailedType =
        getEnumByValidator(passwordFailed);

    return LoginValidationModel(
      emailFailedType,
      passwordFailedType,
    );
  }
}
