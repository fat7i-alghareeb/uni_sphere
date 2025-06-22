//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import 'package:test/features/announcements/data/mappers/announcement_mappers.dart';
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
  Future<Either<String, List<NewsEntity>>> getStudentAnnouncements() {
    return throwAppException(
      () async {
        final response = await _remote.getStudentAnnouncements();
        return response.announcements.map((e) => e.toEntity()).toList();
      },
    );
  }

  @override
  Future<Either<String, List<NewsEntity>>> getFacultyAnnouncements() {
    return throwAppException(
      () async {
        final response = await _remote.getFacultyAnnouncements();
        return response.announcements.map((e) => e.toEntity()).toList();
      },
    );
  }
}
