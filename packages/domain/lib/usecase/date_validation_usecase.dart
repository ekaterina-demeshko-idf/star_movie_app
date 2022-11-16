import 'package:collection/collection.dart';
import 'package:domain/usecase/usecase.dart';
import 'package:domain/validator/validation_date_error.dart';
import 'package:domain/validator/validator.dart';
import 'package:domain/enum/validation_error_type.dart';

class DateValidationUseCase
    extends BaseValidationUseCase<String, Future<void>> {
  final List<Validator> dateValidationArr;

  DateValidationUseCase(
    this.dateValidationArr,
  );

  @override
  Future<void> call(String params) async {
    final Validator? dateFailed = dateValidationArr
        .firstWhereOrNull((element) => !element.isValid(params));

    final ValidationErrorType? dateFailedType = getEnumByValidator(dateFailed);

    if (dateFailedType != null) {
      throw ValidationDateErrors(
        dateError: dateFailedType,
      );
    }
  }
}
