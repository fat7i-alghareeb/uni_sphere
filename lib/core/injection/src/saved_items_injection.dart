//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';

import '../../../features/saved_items/data/datasources/saved_items_remote_data_source.dart';
import '../../../features/saved_items/data/repositories/saved_items_repository_impl.dart';
import '../../../features/saved_items/domain/repositories/saved_items_repository.dart';
import '../../../features/saved_items/domain/usecases/saved_items_usecase.dart';
import '../injection.dart';

//!----------------------------  The Class  -------------------------------------!//

Future<void> savedItemsInjection() async {
  getIt.registerLazySingleton<SavedItemsRemote>(
    () => SavedItemsRemote(
      getIt<Dio>(),
    ),
  );
  
  getIt.registerLazySingleton<SavedItemsRepo>(
    () => SavedItemsRepoImp(
      remote: getIt<SavedItemsRemote>(),
    ),
  );
  
  getIt.registerLazySingleton<SavedItemsUsecase>(
    () => SavedItemsUsecase(
      repo: getIt<SavedItemsRepo>(),
    ),
  );
}
