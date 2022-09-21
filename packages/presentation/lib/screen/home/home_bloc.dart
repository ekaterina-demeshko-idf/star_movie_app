import 'package:domain/enum/movie_type.dart';
import 'package:domain/usecase/get_movie_list_usecase.dart';
import 'package:presentation/base/bloc.dart';
import 'package:presentation/screen/home/home_screen.dart';
import 'package:presentation/models/movie_model.dart';
import '../../enum/current_tab.dart';
import '../details/details_screen.dart';
import 'home_data.dart';
import '../../mappers/presentation_view_mapper.dart';

abstract class HomeBloc extends Bloc<HomeScreenArguments, HomeData> {
  factory HomeBloc(
    GetMovieListUseCase getMovieListUseCase,
    PresentationViewMapper viewMapper,
  ) =>
      _HomeBloc(
        getMovieListUseCase,
        viewMapper,
      );

  void openDetailsPage(MoviePresentation movie);

  void getMovieData(CurrentTab currentTab);
}

class _HomeBloc extends BlocImpl<HomeScreenArguments, HomeData>
    implements HomeBloc {
  var _screenData = HomeData.init();
  final PresentationViewMapper _viewMapper;

  final GetMovieListUseCase _getMovieListUseCase;

  _HomeBloc(
    this._getMovieListUseCase,
    this._viewMapper,
  );

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  void getTrendingData() async {
    _updateData(isLoading: true);
    final responseTrending = await _getMovieListUseCase(MovieType.trending);
    final List<MoviePresentation> moviesTrending =
        await _viewMapper.mapMovieDataToRequest(responseTrending);
    _screenData = _screenData.copyWith(movieTrending: moviesTrending);
    _updateData(isLoading: false);
  }

  void getAnticipatedData() async {
    _updateData(isLoading: true);
    final responseAnticipated =
        await _getMovieListUseCase(MovieType.anticipated);
    final List<MoviePresentation> moviesAnticipated =
        await _viewMapper.mapMovieDataToRequest(responseAnticipated);
    _screenData = _screenData.copyWith(movieAnticipated: moviesAnticipated);
    _updateData(isLoading: false);
  }

  @override
  void getMovieData(CurrentTab currentTab) async {
    if (currentTab == CurrentTab.anticipated) {
      getAnticipatedData();
    } else if (currentTab == CurrentTab.trending) {
      getTrendingData();
    }
  }

  void setCurrentTab(index) {
    _screenData = _screenData.copyWith(
      currentTab: index == 0 ? CurrentTab.trending : CurrentTab.anticipated,
    );
    _updateData();
  }

  @override
  void openDetailsPage(MoviePresentation movie) {
    appNavigator.push(
      DetailsScreen.page(
        DetailsScreenArguments(
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
