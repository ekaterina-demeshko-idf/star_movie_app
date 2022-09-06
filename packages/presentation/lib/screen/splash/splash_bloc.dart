import 'package:presentation/base/bloc.dart';
import 'package:presentation/screen/splash/splash_data.dart';
import '../home/home_screen.dart';

abstract class SplashBloc extends Bloc {
  factory SplashBloc() => _SplashBloc();
}

class _SplashBloc extends BlocImpl implements SplashBloc {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    Future.delayed(
      const Duration(seconds: 3),
      () => appNavigator.popAndPush(
        HomeScreen.page(
          HomeScreenArguments(),
        ),
      ),
    );
  }
}
