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
    String value = newValue.text;
    if (newValue.text == '3' ||
        newValue.text == '37' ||
        newValue.text.startsWith('375')) {
      if (newValue.text.isNotEmpty) {
        value = newValue.text.addCharAtPosition('+', 0);
      }
    } else if (newValue.text.length < 4 && newValue.text.isNotEmpty) {
      if (newValue.text.length < 2) {
        value = newValue.text.addCharAtPosition('+375 (', 0);
      } else {
        String code = newValue.text.substring(0, 2);
        value = "+375 ($code) ${newValue.text.substring(2)}";
      }
    }
    if (newValue.text.length >= 4) {
      value = value.addCharAtPosition(' (', 4);
    }
    if (newValue.text.length >= 6) {
      value = value.addCharAtPosition(') ', 8);
    }
    if (newValue.text.length >= 9) {
      value = value.addCharAtPosition('-', 13);
    }
    if (newValue.text.length >= 11) {
      value = value.addCharAtPosition('-', 16);
    }
    if (newValue.text.length > 12) {
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
