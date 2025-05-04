//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';

import '../../../features/search/data/datasources/search_remote_data_source.dart';
import '../../../features/search/data/repositories/search_repository_impl.dart';
import '../../../features/search/domain/repositories/search_repository.dart';
import '../../../features/search/domain/usecases/search_usecase.dart';
import '../injection.dart';

//!----------------------------  The Class  -------------------------------------!//

Future<void> searchInjection() async {
  getIt.registerLazySingleton<SearchRemote>(
    () => SearchRemote(
      getIt<Dio>(),
    ),
  );
  
  getIt.registerLazySingleton<SearchRepo>(
    () => SearchRepoImp(
      remote: getIt<SearchRemote>(),
    ),
  );
  
  getIt.registerLazySingleton<SearchUsecase>(
    () => SearchUsecase(
      repo: getIt<SearchRepo>(),
    ),
  );
}
