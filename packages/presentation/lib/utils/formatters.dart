import 'package:domain/utils/extensions/string_extension.dart';
import 'package:flutter/services.dart';

class CustomCardFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final List inputChars = newValue.text.split('');
    String result = '';
    List newString = [];
    if (newValue.text.length > oldValue.text.split(' ').join('').length) {
      for (var i = 0; i < inputChars.length; i++) {
        if (i == 3 || i == 7 || i == 11) {
          newString.add(inputChars[i]);
          newString.add(' ');
        } else {
          newString.add(inputChars[i]);
        }
      }
      result = newString.join('');
    } else {
      result = oldValue.text.substring(0, oldValue.text.length - 1);
    }

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
    final List inputChars = newValue.text.split('');
    List newString = [];
    for (var i = 0; i < inputChars.length; i++) {
      if (i == 2) {
        newString.add('/');
        newString.add(inputChars[i]);
      } else {
        newString.add(inputChars[i]);
      }
    }
    final result = newString.join('');

    return TextEditingValue(
      text: result,
      selection: TextSelection.collapsed(
        offset: result.length,
      ),
    );
  }
}

class CheckFormatterList extends TextInputFormatter {
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
    } else if (newValue.text.length < 4 && newValue.text.isNotEmpty) {
      if (newValue.text.length < 2) {
        value = newValue.text.addCharAtPosition('+375 (', 0);
      } else if (newValue.text.length < 3) {
        value = "+375 (${newValue.text})";
      } else {
        String code = newValue.text.substring(0, 2);
        value = "+375 ($code) ${newValue.text.substring(2)}";
      }
    }

    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(
        offset: value.length,
      ),
    );
  }
}
