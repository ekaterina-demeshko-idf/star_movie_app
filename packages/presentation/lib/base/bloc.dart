import 'dart:async';
import 'package:flutter/material.dart';
import 'bloc_data.dart';

abstract class Bloc {
  Stream<BlocData> get dataStream;

  void initState();
}

abstract class BlocImpl implements Bloc {
  final _data = StreamController<BlocData>();
  final _blocData = BlocData.init();

  @override
  Stream<BlocData> get dataStream => _data.stream;

  @protected
  void handleData({dynamic data}) {
    _blocData.updateParams(data);
    _data.add(_blocData.copy());
  }

  @override
  void initState() {}
}
