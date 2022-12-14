import 'package:domain/repository/local_storage_repository.dart';
import 'package:domain/repository/remote_db_repository.dart';
import 'package:domain/usecase/date_validation_usecase.dart';
import 'package:domain/usecase/get_cast_usecase.dart';
import 'package:domain/usecase/google_auth_usecase.dart';
import 'package:domain/usecase/imitate_api_call_usecase.dart';
import 'package:domain/usecase/login_validation_usecase.dart';
import 'package:domain/usecase/save_credentials_usecase.dart';
import 'package:domain/validator/validator.dart';
import 'package:get_it/get_it.dart';
import '../repository/auth_repository.dart';
import '../repository/tmdb_api_repository.dart';
import '../repository/trakt_api_repository.dart';
import '../services/analytics_service.dart';
import '../usecase/analytics_event_usecase.dart';
import '../usecase/analytics_screen_usecase.dart';
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
  GetIt.I.registerFactory<LoginValidationUseCase>(
    () {
      const String passwordValidationRegEx = '^[A-Za-z0-9]{7,}\$';
      const int minLength = 8;
      return LoginValidationUseCase(
        [
          RequiredField(),
          MinLength(minLength),
        ],
        [
          RequiredField(),
          RegEx(passwordValidationRegEx),
        ],
      );
    },
  );
  GetIt.I.registerFactory<DateValidationUseCase>(
    () {
      return DateValidationUseCase(
        [
          RequiredField(),
          MonthValidation(),
          DateValidation(),
        ],
      );
    },
  );
  GetIt.I.registerFactory<GetMovieListUseCase>(
    () => GetMovieListUseCase(
      GetIt.I.get<TraktAPIRepository>(),
      GetIt.I.get<LocalStorageRepository>(),
    ),
  );
  GetIt.I.registerFactory<CheckUserUseCase>(
    () => CheckUserUseCase(
      GetIt.I.get<RemoteDBRepository>(),
    ),
  );
  GetIt.I.registerFactory<GoogleAuthUseCase>(
    () => GoogleAuthUseCase(GetIt.I.get<AuthRepository>()),
  );
  GetIt.I.registerFactory<FacebookAuthUseCase>(
    () => FacebookAuthUseCase(GetIt.I.get<AuthRepository>()),
  );
  GetIt.I.registerFactory<LogAnalyticsEventUseCase>(
    () => LogAnalyticsEventUseCase(
      GetIt.I.get<AnalyticsService>(),
    ),
  );
  GetIt.I.registerFactory<LogAnalyticsScreenUseCase>(
    () => LogAnalyticsScreenUseCase(
      GetIt.I.get<AnalyticsService>(),
    ),
  );
  GetIt.I.registerFactory<SaveCredentialsUseCase>(
    () => SaveCredentialsUseCase(
      GetIt.I.get<LocalStorageRepository>(),
    ),
  );
  GetIt.I.registerFactory<GetCastUseCase>(
    () => GetCastUseCase(
      GetIt.I.get<TraktAPIRepository>(),
      GetIt.I.get<TmdbAPIRepository>(),
      GetIt.I.get<LocalStorageRepository>(),
    ),
  );
}
