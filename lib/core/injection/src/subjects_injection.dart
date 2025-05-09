//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import 'package:test/features/subjects/domain/usecases/get_year_subjects_usecase.dart';

import '../../../features/subjects/data/datasources/subjects_remote_data_source.dart';
import '../../../features/subjects/data/repositories/subjects_repository_impl.dart';
import '../../../features/subjects/domain/repositories/subjects_repository.dart';
import '../../../features/subjects/domain/usecases/subjects_usecase.dart';
import '../../../features/subjects/presentation/state/subjects_bloc/subjects_bloc.dart';
import '../injection.dart';

//!----------------------------  The Class  -------------------------------------!//

Future<void> subjectsInjection() async {
  getIt.registerLazySingleton<SubjectsRemote>(
    () => SubjectsRemote(
      getIt<Dio>(),
    ),
  );

  getIt.registerLazySingleton<SubjectsRepo>(
    () => SubjectsRepoImp(
      remote: getIt<SubjectsRemote>(),
    ),
  );

  getIt.registerLazySingleton<SubjectsUsecase>(
    () => SubjectsUsecase(
      repo: getIt<SubjectsRepo>(),
    ),
  );

  getIt.registerLazySingleton<GetYearSubjectsUsecase>(
    () => GetYearSubjectsUsecase(
      repo: getIt<SubjectsRepo>(),
    ),
  );

  getIt.registerFactory<SubjectsBloc>(
    () => SubjectsBloc(
      usecase: getIt<SubjectsUsecase>(),
      getYearSubjectsUsecase: getIt<GetYearSubjectsUsecase>(),
    ),
  );
}
