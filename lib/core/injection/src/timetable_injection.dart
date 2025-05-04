//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';

import '../../../features/timetable/data/datasources/timetable_remote_data_source.dart';
import '../../../features/timetable/data/repositories/timetable_repository_impl.dart';
import '../../../features/timetable/domain/repositories/timetable_repository.dart';
import '../../../features/timetable/domain/usecases/timetable_usecase.dart';
import '../injection.dart';

//!----------------------------  The Class  -------------------------------------!//

Future<void> timetableInjection() async {
  getIt.registerLazySingleton<TimetableRemote>(
    () => TimetableRemote(
      getIt<Dio>(),
    ),
  );
  
  getIt.registerLazySingleton<TimetableRepo>(
    () => TimetableRepoImp(
      remote: getIt<TimetableRemote>(),
    ),
  );
  
  getIt.registerLazySingleton<TimetableUsecase>(
    () => TimetableUsecase(
      repo: getIt<TimetableRepo>(),
    ),
  );
}
