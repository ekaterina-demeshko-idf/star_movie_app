enum TypeError {
  requiredTypeError,
  minLengthTypeError,
  regexTypeError,
}

abstract class Validator {
  TypeError? isValid(Object a);
}

class RequiredField implements Validator {
  @override
  TypeError? isValid(Object a) {
    if (a is String) {
      a.isNotEmpty ? null : TypeError.requiredTypeError;
    }
    return null;
  }
}

class MinLength implements Validator {
  int minLength;

  MinLength(this.minLength);

  @override
  TypeError? isValid(Object a) {
    if (a is String) {
      a.length >= minLength ? null : TypeError.minLengthTypeError;
    }
    return null;
  }
}

class RegEx implements Validator {
  String regExPattern;

  RegEx(this.regExPattern);

  @override
  TypeError? isValid(Object a) {
    if (a is String) {
      return RegExp(regExPattern).allMatches(a).isNotEmpty
          ? null
          : TypeError.regexTypeError;
    }
    return null;
  }
}
