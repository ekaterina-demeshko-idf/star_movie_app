import 'package:domain/model/login_model.dart';
import 'package:domain/usecase/usecase.dart';
import 'package:domain/validator/validator.dart';

class LoginValidationUseCase
    extends BaseValidationUseCase<LoginModel, Future<void>> {
  @override
  Future<void> call(LoginModel params) async {
    const String passwordValidationRegEx = '^[A-Za-z0-9]{7,}\$';

    List emailValidationArr = [
      RequiredField(),
      MinLength(8),
    ];
    List passwordValidationArr = [
      RequiredField(),
      MinLength(8),
      RegEx(passwordValidationRegEx),
    ];
    final Validator emailFailed = emailValidationArr
        .firstWhere((element) => element.isValid(params.email));
    final TypeError? emailFailedType = getEnumByValidator(emailFailed);
    final Validator passwordFailed = passwordValidationArr
        .firstWhere((element) => element.isValid(params.password));
    final TypeError? passwordFailedType = getEnumByValidator(passwordFailed);
  }
}
