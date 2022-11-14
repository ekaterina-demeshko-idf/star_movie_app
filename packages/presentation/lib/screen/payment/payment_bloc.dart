import 'package:domain/usecase/date_validation_usecase.dart';
import 'package:domain/validator/validation_date_error.dart';
import 'package:flutter/material.dart';
import 'package:presentation/base/bloc.dart';
import 'package:presentation/models/validation_date_model.dart';

abstract class PaymentBloc extends Bloc {
  factory PaymentBloc(
    DateValidationUseCase dateValidationUseCase,
  ) =>
      _PaymentBloc(dateValidationUseCase);

  TextEditingController get dateController;

  ValidationDateModel? validationModel;

  GlobalKey<FormState> get formKey;

  void onValidate();

  void onChangedTextForm();
}

class _PaymentBloc extends BlocImpl implements PaymentBloc {
  final DateValidationUseCase _dateValidationUseCase;
  final _dateController = TextEditingController();

  _PaymentBloc(this._dateValidationUseCase);

  @override
  TextEditingController get dateController => _dateController;

  @override
  ValidationDateModel? validationModel;

  final _formKey = GlobalKey<FormState>();

  @override
  GlobalKey<FormState> get formKey => _formKey;

  @override
  void onValidate() async {
    final String date = _dateController.text.trim();
    try {
      await _dateValidationUseCase(date);
    } on ValidationDateErrors catch (e) {
      validationModel = ValidationDateModel(
        e.dateError,
      );
      _formKey.currentState?.validate();
    }
  }

  @override
  void onChangedTextForm() {
    validationModel = ValidationDateModel(
      null,
    );
    formKey.currentState?.validate();
  }
}
