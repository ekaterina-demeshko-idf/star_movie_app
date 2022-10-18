abstract class Validator {
  bool isValid(Object a);
}

class RequiredField implements Validator {
  @override
  bool isValid(Object a) {
    if (a is String) {
      return a.isNotEmpty ? true : false;
    }
    return false;
  }
}

class MinLength implements Validator {
  int minLength;

  MinLength(this.minLength);

  @override
  bool isValid(Object a) {
    if (a is String) {
      return a.length >= minLength ? true : false;
    }
    return false;
  }
}

class RegEx implements Validator {
  String regExPattern;

  RegEx(this.regExPattern);

  @override
  bool isValid(Object a) {
    if (a is String) {
      return RegExp(regExPattern).allMatches(a).isNotEmpty ? true : false;
    }
    return false;
  }
}
