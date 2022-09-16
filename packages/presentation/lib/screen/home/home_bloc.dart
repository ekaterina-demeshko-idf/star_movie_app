import 'package:domain/usecase/get_movie_anticipated_response_usecase.dart';
import 'package:presentation/base/bloc.dart';
import 'package:domain/usecase/get_movie_trending_response_usecase.dart';
import 'package:presentation/screen/home/home_screen.dart';
import 'package:presentation/screen/home/movie_model.dart';
import '../details/details_page.dart';
import 'home_data.dart';

abstract class HomeBloc extends Bloc<HomeScreenArguments, HomeData> {
  factory HomeBloc(
    GetMovieTrendingResponseUseCase getMovieTrendingResponseUseCase,
    GetMovieAnticipatedResponseUseCase getMovieAnticipatedResponseUseCase,
  ) =>
      _HomeBloc(
        getMovieTrendingResponseUseCase,
        getMovieAnticipatedResponseUseCase,
      );

  void openDetailsPage(MoviePresentation movie);
}

class _HomeBloc extends BlocImpl<HomeScreenArguments, HomeData>
    implements HomeBloc {
  HomeData _screenData = HomeData.init();

  final GetMovieTrendingResponseUseCase _getMovieTrendingResponseUseCase;
  final GetMovieAnticipatedResponseUseCase _getMovieAnticipatedResponseUseCase;

  _HomeBloc(
    this._getMovieTrendingResponseUseCase,
    this._getMovieAnticipatedResponseUseCase,
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
    final List<MoviePresentation> moviesTrending = responseTrending
        .map((e) => MoviePresentation.fromMovie(e.movie))
        .toList();
    final List<MoviePresentation> moviesAnticipated = responseAnticipated
        .map((e) => MoviePresentation.fromMovie(e.movie))
        .toList();
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
