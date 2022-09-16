import 'package:domain/usecase/imitate_api_call_usecase.dart';
import 'package:get_it/get_it.dart';
import '../repository/movie_repository.dart';
import '../usecase/get_movie_response_usecase.dart';

void initDomainInjector() {
  _initUseCaseModule();
}

void _initUseCaseModule() {
  GetIt.I.registerFactory<ImitateApiCallUseCase>(
    () => ImitateApiCallUseCase(),
  );
  GetIt.I.registerFactory<GetMovieResponseUseCase>(
        () => GetMovieResponseUseCase(
      GetIt.I.get<NetworkRepository>(),
    ),
  );
}
