//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../../../features/help/data/datasources/help_remote_data_source.dart';
import '../../../features/help/data/repositories/help_repository_impl.dart';
import '../../../features/help/domain/repositories/help_repository.dart';
import '../../../features/help/domain/usecases/help_usecase.dart';
import '../injection.dart';

//!----------------------------  The Class  -------------------------------------!//

Future<void> helpInjection() async {
  getIt.registerLazySingleton<HelpRemote>(
    () => HelpRemote(
      getIt<Dio>(),
    ),
  );
  
  getIt.registerLazySingleton<HelpRepo>(
    () => HelpRepoImp(
      remote: getIt<HelpRemote>(),
    ),
  );
  
  getIt.registerLazySingleton<HelpUsecase>(
    () => HelpUsecase(
      repo: getIt<HelpRepo>(),
    ),
  );
}
