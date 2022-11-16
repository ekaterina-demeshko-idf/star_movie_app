import 'package:collection/collection.dart';
import 'package:domain/model/user/user_model.dart';
import 'package:domain/usecase/usecase.dart';
import 'package:domain/validator/validation_login_error.dart';
import 'package:domain/validator/validator.dart';
import 'package:domain/enum/validation_error_type.dart';

class LoginValidationUseCase
    extends BaseValidationUseCase<UserModel, Future<void>> {
  final List<Validator> emailValidationArr;
  final List<Validator> passwordValidationArr;

  LoginValidationUseCase(
    this.emailValidationArr,
    this.passwordValidationArr,
  );

  @override
  Future<void> call(UserModel params) async {
    final Validator? emailFailed = emailValidationArr.firstWhereOrNull(
        (element) => !element.isValid(params.email as String));

    final ValidationErrorType? emailFailedType =
        getEnumByValidator(emailFailed);

    final Validator? passwordFailed = passwordValidationArr.firstWhereOrNull(
        (element) => !element.isValid(params.password as String));

    final ValidationErrorType? passwordFailedType =
        getEnumByValidator(passwordFailed);
    if (emailFailedType != null || passwordFailedType != null) {
      throw ValidationLoginErrors(
        emailError: emailFailedType,
        passwordError: passwordFailedType,
      );
    }
  }
}
