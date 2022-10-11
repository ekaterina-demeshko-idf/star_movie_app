import 'package:flutter/material.dart';
import 'package:simple_share_native/simple_share_native.dart';
import 'package:domain/model/cast/cast_with_images.dart';
import 'package:presentation/base/bloc.dart';
import 'details_data.dart';
import 'details_screen.dart';
import 'package:domain/usecase/get_cast_usecase.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class DetailsBloc extends Bloc<DetailsScreenArguments, DetailsData> {
  factory DetailsBloc(
    GetCastUseCase getCastUseCase,
  ) =>
      _DetailsBloc(getCastUseCase);

  Future<void> shareMovie(BuildContext context);

}

class _DetailsBloc extends BlocImpl<DetailsScreenArguments, DetailsData>
    implements DetailsBloc {
  DetailsData _screenData = DetailsData();

  final GetCastUseCase _getCastUseCase;

  final _simpleShareNativePlugin = SimpleShareNative();

  _DetailsBloc(this._getCastUseCase);


  @override
  void initArgs(DetailsScreenArguments arguments) {
    super.initArgs(arguments);
    _screenData = DetailsData(movie: arguments.movie);
    getCastData(arguments.movie.traktId);
    _updateData();
  }

  @override
  Future<void> shareMovie(BuildContext context) async {
    final traktId = _screenData.movie?.traktId ?? 0;
    final message = AppLocalizations.of(context)!.share(traktId);
    await _simpleShareNativePlugin.shareMessage(message);
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
