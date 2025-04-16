//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../../../features/grades/data/datasources/grades_remote_data_source.dart';
import '../../../features/grades/data/repositories/grades_repository_impl.dart';
import '../../../features/grades/domain/repositories/grades_repository.dart';
import '../../../features/grades/domain/usecases/grades_usecase.dart';
import '../injection.dart';

//!----------------------------  The Class  -------------------------------------!//

Future<void> gradesInjection() async {
  getIt.registerLazySingleton<GradesRemote>(
    () => GradesRemote(
      getIt<Dio>(),
    ),
  );
  
  getIt.registerLazySingleton<GradesRepo>(
    () => GradesRepoImp(
      remote: getIt<GradesRemote>(),
    ),
  );
  
  getIt.registerLazySingleton<GradesUsecase>(
    () => GradesUsecase(
      repo: getIt<GradesRepo>(),
    ),
  );
}
