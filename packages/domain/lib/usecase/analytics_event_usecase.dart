import 'package:domain/services/analytics_service.dart';
import 'package:domain/usecase/usecase.dart';

class LogAnalyticsEventUseCase
    implements UseCaseParams<String, Future<void>> {
  final AnalyticsService _analyticsService;

  LogAnalyticsEventUseCase(this._analyticsService);

  @override
  Future<void> call(String params) async =>
      _analyticsService.logEvent(
        'screen_view',
        parameters: {'screen': params},
      );
}
