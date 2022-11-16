import 'package:domain/utils/extensions/string_extension.dart';
import 'package:flutter/services.dart';

class CustomCardFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    RegExp exp = RegExp(r"\d{" "1,4" "}");
    Iterable<Match> matches = exp.allMatches(newValue.text);
    var list = matches.map((m) => m.group(0));
    String result = list.join(' ');

    return TextEditingValue(
      text: result,
      selection: TextSelection.collapsed(
        offset: result.length,
      ),
    );
  }
}

class CustomDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    RegExp exp = RegExp(r"\d{" "1,2" "}");
    Iterable<Match> matches = exp.allMatches(newValue.text);
    var list = matches.map((m) => m.group(0));
    String result = list.join('/');

    return TextEditingValue(
      text: result,
      selection: TextSelection.collapsed(
        offset: result.length,
      ),
    );
  }
}

class CustomPhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String value = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (value == '3' || value == '37' || value.startsWith('375')) {
      value = value.addCharAtPosition('+', 0);
    } else {
      if (newValue.text != '+') {
        value = value.addCharAtPosition('+375', 0);
      }
    }
    if (value.length >= 5) {
      value = value.addCharAtPosition(' (', 4);
    }
    if (value.length >= 9) {
      value = value.addCharAtPosition(') ', 8);
    }
    if (value.length >= 14) {
      value = value.addCharAtPosition('-', 13);
    }
    if (value.length >= 17) {
      value = value.addCharAtPosition('-', 16);
    }
    if (value.length > 19) {
      value = oldValue.text;
    }

    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(
        offset: value.length,
      ),
    );
  }
}
