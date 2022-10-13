import 'package:domain/services/analytics_service.dart';
import 'package:domain/usecase/usecase.dart';

class LogAnalyticsScreenUseCase implements UseCaseParams<String, Future<void>> {
  final AnalyticsService _analyticsService;

  LogAnalyticsScreenUseCase(this._analyticsService);

  @override
  Future<void> call(String screen) async => _analyticsService.logEvent(
        'screen_view',
        parameters: {'screen': screen},
      );
}
