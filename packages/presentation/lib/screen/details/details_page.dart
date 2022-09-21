import 'package:flutter/material.dart';
import 'package:presentation/screen/home/movie_model.dart';

import '../../navigation/base_arguments.dart';
import '../../navigation/base_page.dart';

class DetailsPageArguments extends BaseArguments {
  final MoviePresentation movie;

  DetailsPageArguments({
    required this.movie,
    Function(dynamic value)? result,
  }) : super(result: result);
}

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  static const _routeName = '/DetailsPage';

  static BasePage page(DetailsPageArguments arguments) => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (context) => const DetailsPage(),
        arguments: arguments,
        hideNavBar: false,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('details'),
      ),
      body: Container(
        child: Center(
          child: Text(
            'DETAILS PAGE',
            style: TextStyle(color: Colors.white, fontSize: 39),
          ),
        ),
      ),
    );
  }
}
