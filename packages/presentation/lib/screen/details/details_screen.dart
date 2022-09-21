import 'package:flutter/material.dart';
import 'package:presentation/models/movie_model.dart';
import '../../navigation/base_arguments.dart';
import '../../navigation/base_page.dart';

class DetailsScreenArguments extends BaseArguments {
  final MoviePresentation movie;

  DetailsScreenArguments({
    required this.movie,
    Function(dynamic value)? result,
  }) : super(result: result);
}

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  static const _routeName = '/DetailsPage';

  static BasePage page(DetailsScreenArguments arguments) => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (context) => const DetailsScreen(),
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
