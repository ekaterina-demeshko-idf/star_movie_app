import 'package:domain/usecase/get_movie_anticipated_response_usecase.dart';
import 'package:presentation/base/bloc.dart';
import 'package:domain/usecase/get_movie_trending_response_usecase.dart';
import 'package:presentation/screen/home/home_screen.dart';
import 'package:presentation/screen/home/movie_model.dart';
import '../details/details_page.dart';
import 'home_data.dart';
import 'home_view_mapper.dart';

abstract class HomeBloc extends Bloc<HomeScreenArguments, HomeData> {
  factory HomeBloc(
    GetMovieTrendingResponseUseCase getMovieTrendingResponseUseCase,
    GetMovieAnticipatedResponseUseCase getMovieAnticipatedResponseUseCase,
    HomeViewMapper viewMapper,
  ) =>
      _HomeBloc(
        getMovieTrendingResponseUseCase,
        getMovieAnticipatedResponseUseCase,
        viewMapper,
      );

  void openDetailsPage(MoviePresentation movie);
}

class _HomeBloc extends BlocImpl<HomeScreenArguments, HomeData>
    implements HomeBloc {
  HomeData _screenData = HomeData.init();
  final HomeViewMapper _viewMapper;

  final GetMovieTrendingResponseUseCase _getMovieTrendingResponseUseCase;
  final GetMovieAnticipatedResponseUseCase _getMovieAnticipatedResponseUseCase;

  _HomeBloc(
    this._getMovieTrendingResponseUseCase,
    this._getMovieAnticipatedResponseUseCase,
    this._viewMapper,
  );

  @override
  void initState() {
    super.initState();
    getInitialData();
  }

  void getInitialData() async {
    _updateData(isLoading: true);
    final responseAnticipated = await _getMovieAnticipatedResponseUseCase();
    final responseTrending = await _getMovieTrendingResponseUseCase();
    final List<MoviePresentation> moviesTrending =
        await _viewMapper.mapTrendingDataToRequest(responseTrending);
    final List<MoviePresentation> moviesAnticipated =
        await _viewMapper.mapAnticipatedDataToRequest(responseAnticipated);
    _screenData = HomeData(moviesTrending, moviesAnticipated);
    _updateData(isLoading: false);
  }

  @override
  void openDetailsPage(MoviePresentation movie) {
    appNavigator.push(
      DetailsPage.page(
        DetailsPageArguments(
          movie: movie,
        ),
      ),
    );
  }

  _updateData({bool? isLoading}) {
    handleData(
      data: _screenData,
      isLoading: isLoading,
    );
  }
}
