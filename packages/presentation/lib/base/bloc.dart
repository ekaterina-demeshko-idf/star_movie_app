import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../navigation/app_navigator.dart';
import 'package:presentation/navigation/base_arguments.dart';
import 'bloc_data.dart';

abstract class Bloc<T extends BaseArguments, D> {
  Stream<BlocData<D?>> get dataStream;

  void initState();

  void initArgs(T args);

  void dispose();
}

abstract class BlocImpl<T extends BaseArguments, D> implements Bloc<T, D> {
  final _data = StreamController<BlocData<D?>>();
  final _blocData = BlocData.init();

  @protected
  final appNavigator = GetIt.I.get<AppNavigator>();

  @override
  Stream<BlocData<D?>> get dataStream => _data.stream;

  @protected
  void handleData({D? data}) {
    _blocData.updateParams(data);
    _data.add(_blocData.copy<D>());
  }

  @override
  void initState() {}

  @override
  void initArgs(T arguments) {}

  @override
   void dispose() {
  //   _data.close();
  }
}
