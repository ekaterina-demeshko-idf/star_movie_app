import 'package:domain/usecase/get_movie_anticipated_response_usecase.dart';
import 'package:presentation/base/bloc.dart';
import 'package:domain/usecase/get_movie_trending_response_usecase.dart';
import 'package:presentation/screen/home/home_screen.dart';
import 'home_data.dart';

abstract class HomeBloc extends Bloc<HomeScreenArguments, HomeData> {
  factory HomeBloc(
    GetMovieTrendingResponseUseCase getMovieTrendingResponseUseCase,
    GetMovieAnticipatedResponseUseCase getMovieAnticipatedResponseUseCase,
  ) =>
      _HomeBloc(
          getMovieTrendingResponseUseCase, getMovieAnticipatedResponseUseCase);

  void onItemTapped(int index);
}

class _HomeBloc extends BlocImpl<HomeScreenArguments, HomeData>
    implements HomeBloc {
  int? selectedIndex = 1;
  HomeData _screenData = HomeData.init();
  final GetMovieTrendingResponseUseCase _getMovieTrendingResponseUseCase;
  final GetMovieAnticipatedResponseUseCase _getMovieAnticipatedResponseUseCase;

  _HomeBloc(this._getMovieTrendingResponseUseCase,
      this._getMovieAnticipatedResponseUseCase);

  @override
  void initState() async {
    super.initState();
    _updateData(isLoading: true);
    final responseAnticipated = await _getMovieAnticipatedResponseUseCase();
    final responseTrending = await _getMovieTrendingResponseUseCase();
    _screenData = HomeData(0, responseTrending, responseAnticipated);
    _updateData(isLoading: false);
  }

  @override
  void initArgs(HomeScreenArguments arguments) {
    super.initArgs(arguments);
    _screenData =
        HomeData(0, arguments.movieResponse, arguments.anticipatedResponse);
    _updateData();
  }

  @override
  void onItemTapped(int index) {
    selectedIndex = index;
    _updateData();
  }

  _updateData({bool? isLoading}) {
    handleData(
      data: _screenData,
      isLoading: isLoading,
    );
  }
}
