import 'package:presentation/base/bloc.dart';
import 'home_data.dart';

abstract class HomeBloc extends Bloc {
  factory HomeBloc() => _HomeBloc();

  void onItemTapped(int index);
}

class _HomeBloc extends BlocImpl implements HomeBloc {
  int? selectedIndex = 1;
  final _screenData = HomeData.init();

  _HomeBloc();

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  @override
  void onItemTapped(int index) {
    selectedIndex = index;
    _updateData();
  }

  _updateData() {
    handleData(
      data: _screenData,
    );
  }
}
