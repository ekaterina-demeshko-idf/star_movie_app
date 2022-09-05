import 'package:flutter/material.dart';

import 'base_arguments.dart';

class BasePage<T extends BaseArguments> extends Page {
  const BasePage({
    @required required LocalKey key,
    @required required String name,
    @required required this.builder,
    T? arguments,
  }) : super(key: key, name: name, arguments: arguments);

  final WidgetBuilder builder;

  @override
  Route createRoute(BuildContext context) => _AppRoute(
        settings: this,
        builder: builder,
      );
}

class _AppRoute extends MaterialPageRoute {
  _AppRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
  }) : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return super.buildTransitions(
      context,
      animation,
      secondaryAnimation,
      child,
    );
  }
}
