import 'package:flutter/material.dart';
import 'package:presentation/base/bloc.dart';

abstract class PaymentBloc extends Bloc {
  factory PaymentBloc() => _PaymentBloc();

  GlobalKey<FormState> get formKey;

  String? validateDate(String? value);
}

class _PaymentBloc extends BlocImpl implements PaymentBloc {
  final _formKey = GlobalKey<FormState>();

  @override
  GlobalKey<FormState> get formKey => _formKey;

  @override
  String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    }
    int year;
    int month;
    if (value.contains(RegExp(r'(/)'))) {
      List<String> split = value.split(RegExp(r'(/)'));
      month = int.parse(split[0]);
      year = int.parse(split[1]);
    } else {
      month = int.parse(value.substring(0, (value.length)));
      year = -1;
    }
    if ((month < 1) || (month > 12)) {
      return 'Month is invalid';
    }
    if (year > -1 && _hasDateExpired(month, year)) {
      return "Card has expired";
    }
    return null;
  }

  bool _hasDateExpired(int month, int year) {
    DateTime now = DateTime.now();
    String currentYear = now.year.toString();
    bool yearPassed = year < int.parse(currentYear.substring(2));
    bool monthPassed = month < now.month + 1;
    if (yearPassed ||
        (year == int.parse(currentYear.substring(2)) && monthPassed)) {
      return true;
    }
    return false;
  }
}
