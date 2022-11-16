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

class MonthValidation implements Validator {
  @override
  bool isValid(Object value) {
    if (value is String) {
      int month;
      if (value.contains(RegExp(r'(/)'))) {
        List<String> split = value.split(RegExp(r'(/)'));
        month = int.parse(split[0]);
        if ((month < 1) || (month > 12)) {
          return false;
        }
        return true;
      }
    }
    return false;
  }
}

class DateValidation implements Validator {
  @override
  bool isValid(Object value) {
    if (value is String) {
      int month;
      int year;
      if (value.contains(RegExp(r'(/)'))) {
        List<String> split = value.split(RegExp(r'(/)'));
        month = int.parse(split[0]);
        year = int.parse(split[1]);
      } else {
        month = int.parse(value.substring(0, (value.length)));
        year = -1;
      }
      DateTime now = DateTime.now();
      String currentYear = now.year.toString();
      bool yearPassed = year < int.parse(currentYear.substring(2));
      bool monthPassed = month < now.month + 1;
      if (yearPassed ||
          (year == int.parse(currentYear.substring(2)) && monthPassed)) {
        return false;
      }
      return true;
    }
    return false;
  }
}
