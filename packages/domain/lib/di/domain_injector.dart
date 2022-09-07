import 'package:domain/usecase/imitate_api_call_usecase.dart';
import 'package:get_it/get_it.dart';

void initDomainInjector() {
  _initUseCaseModule();
}

void _initUseCaseModule() {
  GetIt.I.registerFactory<ImitateApiCallUseCase>(
        () => ImitateApiCallUseCase(),
  );

}
