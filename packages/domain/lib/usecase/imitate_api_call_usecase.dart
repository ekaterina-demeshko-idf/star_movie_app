import 'usecase.dart';

class ImitateApiCallUseCase implements UseCase<Future<void>> {
  static const int delaySeconds = 3;

  @override
  Future<void> call() async {
    await Future.delayed(
      const Duration(seconds: delaySeconds),
    );
  }
}
