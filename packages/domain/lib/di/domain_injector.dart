import 'package:domain/repository/firestore_repository.dart';
import 'package:domain/usecase/get_cast_usecase.dart';
import 'package:domain/usecase/google_auth_usecase.dart';
import 'package:domain/usecase/imitate_api_call_usecase.dart';
import 'package:get_it/get_it.dart';
import '../repository/auth_repository.dart';
import '../repository/tmdb_api_repository.dart';
import '../repository/trakt_api_repository.dart';
import '../usecase/check_user_usecase.dart';
import '../usecase/facebook_auth_usecase.dart';
import '../usecase/get_movie_list_usecase.dart';

void initDomainInjector() {
  _initUseCaseModule();
}

void _initUseCaseModule() {
  GetIt.I.registerFactory<ImitateApiCallUseCase>(
    () => ImitateApiCallUseCase(),
  );
  GetIt.I.registerFactory<GetMovieListUseCase>(
    () => GetMovieListUseCase(
      GetIt.I.get<TraktAPIRepository>(),
    ),
  );
  GetIt.I.registerFactory<CheckUserUseCase>(
    () => CheckUserUseCase(
      GetIt.I.get<FirestoreRepository>(),
    ),
  );
  GetIt.I.registerFactory<GoogleAuthUseCase>(
    () => GoogleAuthUseCase(
      GetIt.I.get<AuthRepository>(),
      GetIt.I.get<FirestoreRepository>(),
    ),
  );
  GetIt.I.registerFactory<FacebookAuthUseCase>(
    () => FacebookAuthUseCase(
      GetIt.I.get<AuthRepository>(),
      GetIt.I.get<FirestoreRepository>(),
    ),
  );
  GetIt.I.registerFactory<GetCastUseCase>(
    () => GetCastUseCase(
      GetIt.I.get<TraktAPIRepository>(),
      GetIt.I.get<TmdbAPIRepository>(),
    ),
  );
}
