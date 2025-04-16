//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../../../features/materials/data/datasources/materials_remote_data_source.dart';
import '../../../features/materials/data/repositories/materials_repository_impl.dart';
import '../../../features/materials/domain/repositories/materials_repository.dart';
import '../../../features/materials/domain/usecases/materials_usecase.dart';
import '../injection.dart';

//!----------------------------  The Class  -------------------------------------!//

Future<void> materialsInjection() async {
  getIt.registerLazySingleton<MaterialsRemote>(
    () => MaterialsRemote(
      getIt<Dio>(),
    ),
  );
  
  getIt.registerLazySingleton<MaterialsRepo>(
    () => MaterialsRepoImp(
      remote: getIt<MaterialsRemote>(),
    ),
  );
  
  getIt.registerLazySingleton<MaterialsUsecase>(
    () => MaterialsUsecase(
      repo: getIt<MaterialsRepo>(),
    ),
  );
}
