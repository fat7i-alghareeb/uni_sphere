//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';

import '../../../features/notifications/data/datasources/notifications_remote_data_source.dart';
import '../../../features/notifications/data/repositories/notifications_repository_impl.dart';
import '../../../features/notifications/domain/repositories/notifications_repository.dart';
import '../../../features/notifications/domain/usecases/notifications_usecase.dart';
import '../injection.dart';

//!----------------------------  The Class  -------------------------------------!//

Future<void> notificationsInjection() async {
  getIt.registerLazySingleton<NotificationsRemote>(
    () => NotificationsRemote(
      getIt<Dio>(),
    ),
  );
  
  getIt.registerLazySingleton<NotificationsRepo>(
    () => NotificationsRepoImp(
      remote: getIt<NotificationsRemote>(),
    ),
  );
  
  getIt.registerLazySingleton<NotificationsUsecase>(
    () => NotificationsUsecase(
      repo: getIt<NotificationsRepo>(),
    ),
  );
}
