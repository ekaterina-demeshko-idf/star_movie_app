import 'package:domain/enum/validation_error_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class ErrorViewMapper {
  factory ErrorViewMapper() => _ErrorViewMapper();

  String? mapEmailErrorToMessage(
    BuildContext context,
    ValidationErrorType? error,
  );

  String? mapPasswordErrorToMessage(
    BuildContext context,
    ValidationErrorType? error,
  );

  String? mapDateErrorToMessage(
    BuildContext context,
    ValidationErrorType? error,
  );
}

class _ErrorViewMapper implements ErrorViewMapper {
  @override
  String? mapPasswordErrorToMessage(
    BuildContext context,
    ValidationErrorType? error,
  ) {
    final l10n = AppLocalizations.of(context)!;

    switch (error) {
      case ValidationErrorType.invalidValue:
        return l10n.passwordInvalid;
      case ValidationErrorType.regexTypeError:
        return l10n.passwordInvalid;
      case ValidationErrorType.requiredTypeError:
        return l10n.passwordRequired;
      default:
        return null;
    }
  }

  @override
  String? mapEmailErrorToMessage(
    BuildContext context,
    ValidationErrorType? error,
  ) {
    final l10n = AppLocalizations.of(context)!;

    switch (error) {
      case ValidationErrorType.invalidValue:
        return l10n.emailInvalid;
      case ValidationErrorType.requiredTypeError:
        return l10n.emailRequired;
      case ValidationErrorType.minLengthTypeError:
        return l10n.emailLength;
      default:
        return null;
    }
  }

  @override
  String? mapDateErrorToMessage(
    BuildContext context,
    ValidationErrorType? error,
  ) {
    final l10n = AppLocalizations.of(context)!;

    switch (error) {
      case ValidationErrorType.monthInvalid:
        return 'Month is invalid';
      case ValidationErrorType.dateInvalid:
        return 'Card has expired';
      case ValidationErrorType.requiredTypeError:
        return 'This field is required';
      default:
        return null;
    }
  }
}
