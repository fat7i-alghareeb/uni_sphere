//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import '../../../features/announcements/data/datasources/announcements_remote_data_source.dart';
import '../../../features/announcements/data/repositories/announcements_repository_impl.dart';
import '../../../features/announcements/domain/repositories/announcements_repository.dart';
import '../../../features/announcements/domain/usecases/announcements_usecase.dart';
import '../injection.dart';

//!----------------------------  The Class  -------------------------------------!//

Future<void> announcementsInjection() async {
  getIt.registerLazySingleton<AnnouncementsRemote>(
    () => AnnouncementsRemote(
      getIt<Dio>(),
    ),
  );

  getIt.registerLazySingleton<AnnouncementsRepo>(
    () => AnnouncementsRepoImp(
      remote: getIt<AnnouncementsRemote>(),
    ),
  );

  getIt.registerLazySingleton<AnnouncementsUsecase>(
    () => AnnouncementsUsecase(
      repo: getIt<AnnouncementsRepo>(),
    ),
  );
}
