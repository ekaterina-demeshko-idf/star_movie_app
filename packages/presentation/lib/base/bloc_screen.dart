import 'package:flutter/material.dart';
import 'bloc.dart';

abstract class BlocScreenState<S extends StatefulWidget, B extends Bloc>
    extends State {
  BlocScreenState(this.bloc);

  @protected
  final B bloc;

  @override
  void initState() {
    super.initState();
    bloc.initState();
  }
}
