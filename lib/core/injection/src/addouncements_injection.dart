//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../../../features/addouncements/data/datasources/addouncements_remote_data_source.dart';
import '../../../features/addouncements/data/repositories/addouncements_repository_impl.dart';
import '../../../features/addouncements/domain/repositories/addouncements_repository.dart';
import '../../../features/addouncements/domain/usecases/addouncements_usecase.dart';
import '../injection.dart';

//!----------------------------  The Class  -------------------------------------!//

Future<void> addouncementsInjection() async {
  getIt.registerLazySingleton<AddouncementsRemote>(
    () => AddouncementsRemote(
      getIt<Dio>(),
    ),
  );
  
  getIt.registerLazySingleton<AddouncementsRepo>(
    () => AddouncementsRepoImp(
      remote: getIt<AddouncementsRemote>(),
    ),
  );
  
  getIt.registerLazySingleton<AddouncementsUsecase>(
    () => AddouncementsUsecase(
      repo: getIt<AddouncementsRepo>(),
    ),
  );
}
