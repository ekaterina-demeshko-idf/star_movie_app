import 'package:presentation/base/bloc.dart';
import 'home_data.dart';

abstract class HomeBloc extends Bloc {
  factory HomeBloc() => _HomeBloc();
}

class _HomeBloc extends BlocImpl implements HomeBloc {
  final _screenData = HomeData.init();

  _HomeBloc();

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  _updateData() {
    handleData(
      data: _screenData,
    );
  }
}
