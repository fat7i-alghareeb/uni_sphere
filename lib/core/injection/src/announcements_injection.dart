//!----------------------------  Imports  -------------------------------------!//
import 'package:dio/dio.dart';
import 'package:test/features/announcements/domain/usecases/get_my_announcements_usecase.dart';
import '../../../features/announcements/data/datasources/announcements_remote_data_source.dart';
import '../../../features/announcements/data/repositories/announcements_repository_impl.dart';
import '../../../features/announcements/domain/repositories/announcements_repository.dart';
import '../../../features/announcements/domain/usecases/announcements_usecase.dart';
import '../../../features/announcements/presentation/state/bloc/announcement_bloc.dart';
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
  getIt.registerLazySingleton<GetMyAnnouncementsUsecase>(
    () => GetMyAnnouncementsUsecase(
      repo: getIt<AnnouncementsRepo>(),
    ),
  );

  getIt.registerLazySingleton<AnnouncementBloc>(
    () => AnnouncementBloc(
      usecase: getIt<AnnouncementsUsecase>(),
      getMyAnnouncementsUsecase: getIt<GetMyAnnouncementsUsecase>(),
    ),
  );
}
