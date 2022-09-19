import 'package:domain/enum/movie_type.dart';
import 'package:domain/usecase/get_movie_list_usecase.dart';
import 'package:presentation/base/bloc.dart';
import 'package:presentation/screen/home/home_screen.dart';
import 'package:presentation/screen/home/movie_model.dart';
import '../details/details_page.dart';
import 'home_data.dart';
import 'home_view_mapper.dart';

abstract class HomeBloc extends Bloc<HomeScreenArguments, HomeData> {
  factory HomeBloc(
    GetMovieListUseCase getMovieListUseCase,
    HomeViewMapper viewMapper,
  ) =>
      _HomeBloc(
        getMovieListUseCase,
        viewMapper,
      );

  void openDetailsPage(MoviePresentation movie);
}

class _HomeBloc extends BlocImpl<HomeScreenArguments, HomeData>
    implements HomeBloc {
  HomeData _screenData = HomeData.init();
  final HomeViewMapper _viewMapper;

  final GetMovieListUseCase _getMovieListUseCase;

  _HomeBloc(
    this._getMovieListUseCase,
    this._viewMapper,
  );

  @override
  void initState() {
    super.initState();
    getInitialData();
  }

  void getInitialData() async {
    _updateData(isLoading: true);
    final responseTrending = await _getMovieListUseCase(MovieType.trending);
    final responseAnticipated =
        await _getMovieListUseCase(MovieType.anticipated);

    final List<MoviePresentation> moviesTrending =
        await _viewMapper.mapMovieDataToRequest(responseTrending);
    final List<MoviePresentation> moviesAnticipated =
        await _viewMapper.mapMovieDataToRequest(responseAnticipated);
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
