import 'package:domain/services/analytics_service.dart';
import 'package:domain/usecase/usecase.dart';

class AnalyticsUseCase
    implements UseCaseParams<String, Future<void>> {
  final AnalyticsService _analyticsService;

  AnalyticsUseCase(this._analyticsService);

  @override
  Future<void> call(String params) async {
    await _analyticsService.logClickEvent(params);
  }
}