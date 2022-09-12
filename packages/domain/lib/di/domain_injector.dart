import 'package:domain/usecase/get_movie_trending_response_usecase.dart';
import 'package:domain/usecase/imitate_api_call_usecase.dart';
import 'package:get_it/get_it.dart';
import '../repository/movie_repository.dart';
import '../usecase/get_movie_anticipated_response_usecase.dart';

void initDomainInjector() {
  _initUseCaseModule();
}

void _initUseCaseModule() {
  GetIt.I.registerFactory<ImitateApiCallUseCase>(
    () => ImitateApiCallUseCase(),
  );
  GetIt.I.registerFactory<GetMovieTrendingResponseUseCase>(
    () => GetMovieTrendingResponseUseCase(
      GetIt.I.get<NetworkRepository>(),
    ),
  );
  GetIt.I.registerFactory<GetMovieAnticipatedResponseUseCase>(
        () => GetMovieAnticipatedResponseUseCase(
      GetIt.I.get<NetworkRepository>(),
    ),
  );
}
