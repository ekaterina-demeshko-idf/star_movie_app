import 'package:presentation/base/bloc.dart';
import '../home/home_screen.dart';
import 'package:domain/usecase/imitate_api_call_usecase.dart';

abstract class SplashBloc extends Bloc {
  factory SplashBloc(
    ImitateApiCallUseCase imitateApiCallUseCase,
  ) =>
      _SplashBloc(
        imitateApiCallUseCase,
      );
}

class _SplashBloc extends BlocImpl implements SplashBloc {
  final ImitateApiCallUseCase _imitateApiCallUseCase;

  _SplashBloc(
    this._imitateApiCallUseCase,
  );

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await _imitateApiCallUseCase();
    appNavigator.popAndPush(
      HomeScreen.page(
        HomeScreenArguments(anticipatedResponse: [], movieResponse: []),
      ),
    );
  }
}
