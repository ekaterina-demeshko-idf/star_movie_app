import 'package:domain/model/login_validation_model.dart';
import 'package:domain/model/user/user_model.dart';
import 'package:domain/usecase/usecase.dart';
import 'package:domain/validator/validator.dart';
import 'package:domain/enum/validation_error_type.dart';

class LoginValidationUseCase
    extends BaseValidationUseCase<UserModel, LoginValidationModel?> {
  @override
  LoginValidationModel? call(UserModel params) {
    const String passwordValidationRegEx = '^[A-Za-z0-9]{7,}\$';
    const int minLength = 8;

    List emailValidationArr = [
      RequiredField(),
      MinLength(minLength),
    ];

    List passwordValidationArr = [
      RequiredField(),
      RegEx(passwordValidationRegEx),
    ];

    final Validator? emailFailed = emailValidationArr.firstWhere(
      (element) => !element.isValid(params.email),
      orElse: () => null,
    );

    final ValidationErrorType? emailFailedType =
        getEnumByValidator(emailFailed);

    final Validator? passwordFailed = passwordValidationArr.firstWhere(
      (element) => !element.isValid(params.password),
      orElse: () => null,
    );

    final ValidationErrorType? passwordFailedType =
        getEnumByValidator(passwordFailed);
    return LoginValidationModel(
      emailFailedType,
      passwordFailedType,
    );
  }
}
