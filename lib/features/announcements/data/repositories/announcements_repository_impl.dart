//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/announcement_entity.dart';
import '../datasources/announcements_remote_data_source.dart';
import '../../domain/repositories/announcements_repository.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class AnnouncementsRepoImp implements AnnouncementsRepo {
  final AnnouncementsRemote _remote;

  AnnouncementsRepoImp({
    required AnnouncementsRemote remote,
  }) : _remote = remote;

  @override
  Future<Either<String, AnnouncementEntity>> getAllAnnouncements() {
    return throwAppException(
      () async {
        return await _remote.getAllAnnouncements();
      },
    );
  }
}
