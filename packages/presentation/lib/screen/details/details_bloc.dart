import 'package:domain/model/cast/cast_with_images.dart';
import 'package:presentation/base/bloc.dart';
import 'details_data.dart';
import 'details_screen.dart';
import 'package:domain/usecase/get_cast_usecase.dart';

abstract class DetailsBloc extends Bloc<DetailsScreenArguments, DetailsData> {
  factory DetailsBloc(
    GetCastUseCase getCastUseCase,
  ) =>
      _DetailsBloc(getCastUseCase);
}

class _DetailsBloc extends BlocImpl<DetailsScreenArguments, DetailsData>
    implements DetailsBloc {
  DetailsData _screenData = DetailsData();

  final GetCastUseCase _getCastUseCase;

  _DetailsBloc(this._getCastUseCase);

  @override
  void initState() async {
    super.initState();
  }

  @override
  void initArgs(DetailsScreenArguments arguments) {
    super.initArgs(arguments);
    _screenData = DetailsData(
      movie: arguments.movie,
    );
    getCastData(
      arguments.movie.traktId,
    );
    _updateData();
  }

  void getCastData(int? traktId) async {
    _updateData(isLoading: true);
    final List<CastAndImages>? responseCast = await _getCastUseCase(traktId);
    _screenData = _screenData.copyWith(cast: responseCast);
    _updateData(isLoading: false);
  }

  _updateData({bool? isLoading}) {
    handleData(
      data: _screenData,
      isLoading: isLoading,
    );
  }
}
