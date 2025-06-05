//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';

import '../../../../shared/services/exception/error_handler.dart';
import '../../domain/entities/news_entity.dart';
import '../../domain/repositories/announcements_repository.dart';
import '../datasources/announcements_remote_data_source.dart';

//!----------------------------  The Class  -------------------------------------!//

class AnnouncementsRepoImp implements AnnouncementsRepo {
  final AnnouncementsRemote _remote;

  AnnouncementsRepoImp({
    required AnnouncementsRemote remote,
  }) : _remote = remote;

  @override
  Future<Either<String, NewsEntity>> getAllAnnouncements() {
    return throwAppException(
      () async {
        return await _remote.getAllAnnouncements();
      },
    );
  }
}
