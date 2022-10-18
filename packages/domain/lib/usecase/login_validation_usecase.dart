import 'package:collection/collection.dart';
import 'package:domain/model/login_validation_model.dart';
import 'package:domain/model/user/user_model.dart';
import 'package:domain/usecase/usecase.dart';
import 'package:domain/validator/validator.dart';
import 'package:domain/enum/validation_error_type.dart';

import 'check_user_usecase.dart';

class LoginValidationUseCase
    extends BaseValidationUseCase<UserModel, Future<LoginValidationError?>?> {
  final CheckUserUseCase _checkUserUseCase;

  LoginValidationUseCase(this._checkUserUseCase);

  @override
  Future<LoginValidationError?> call(UserModel params) async {
    const String passwordValidationRegEx = '^[A-Za-z0-9]{7,}\$';
    const int minLength = 8;
    bool? isSuccess = await _checkUserUseCase(params);

    List emailValidationArr = [
      RequiredField(),
      MinLength(minLength),
      UserExist(isSuccess),
    ];

    List passwordValidationArr = [
      RequiredField(),
      RegEx(passwordValidationRegEx),
      UserExist(isSuccess),
    ];

    final Validator? emailFailed = emailValidationArr
        .firstWhereOrNull((element) => !element.isValid(params.email));

    final ValidationErrorType? emailFailedType =
        getEnumByValidator(emailFailed);

    final Validator? passwordFailed = passwordValidationArr
        .firstWhereOrNull((element) => !element.isValid(params.password));

    final ValidationErrorType? passwordFailedType =
        getEnumByValidator(passwordFailed);

    return LoginValidationError(
      emailFailedType,
      passwordFailedType,
    );
  }
}
