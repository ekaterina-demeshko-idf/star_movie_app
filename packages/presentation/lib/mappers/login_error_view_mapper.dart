import 'package:domain/enum/validation_error_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class LoginErrorViewMapper {
  factory LoginErrorViewMapper() => _ErrorViewMapper();

  String? mapEmailErrorToMessage(
    BuildContext context,
    ValidationErrorType? error,
  );

  String? mapPasswordErrorToMessage(
    BuildContext context,
    ValidationErrorType? error,
  );
}

class _ErrorViewMapper implements LoginErrorViewMapper {
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
}
