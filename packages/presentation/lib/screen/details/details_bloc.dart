import 'package:domain/usecase/analytics_event_usecase.dart';
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
    LogAnalyticsEventUseCase logAnalyticsEventUseCase,
  ) =>
      _DetailsBloc(
        getCastUseCase,
        logAnalyticsEventUseCase,
      );

  Future<void> onShareButtonPressed(String message);
}

class _DetailsBloc extends BlocImpl<DetailsScreenArguments, DetailsData>
    implements DetailsBloc {
  DetailsData _screenData = DetailsData();

  final GetCastUseCase _getCastUseCase;
  final LogAnalyticsEventUseCase _logAnalyticsEventUseCase;

  final _simpleShareNativePlugin = SimpleShareNative();

  _DetailsBloc(
    this._getCastUseCase,
    this._logAnalyticsEventUseCase,
  );

  @override
  void initArgs(DetailsScreenArguments arguments) {
    super.initArgs(arguments);
    _screenData = DetailsData(movie: arguments.movie);
    getCastData(arguments.movie.traktId);
    _updateData();
  }

  @override
  Future<void> onShareButtonPressed(String message) async {
    _logAnalyticsEventUseCase('share_button');
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
