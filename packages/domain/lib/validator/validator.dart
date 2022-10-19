abstract class Validator {
  bool isValid(Object value);
}

class RequiredField implements Validator {
  @override
  bool isValid(Object value) {
    if (value is String) {
      return value.isNotEmpty;
    }
    return false;
  }
}

class MinLength implements Validator {
  int minLength;

  MinLength(this.minLength);

  @override
  bool isValid(Object value) {
    if (value is String) {
      return value.length >= minLength;
    }
    return false;
  }
}

class RegEx implements Validator {
  String regExPattern;

  RegEx(this.regExPattern);

  @override
  bool isValid(Object value) {
    if (value is String) {
      return RegExp(regExPattern).allMatches(value).isNotEmpty;
    }
    return false;
  }
}
