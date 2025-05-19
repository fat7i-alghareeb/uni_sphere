//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';

import '../entities/announcement_entity.dart';
import '../repositories/announcements_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class GetMyAnnouncementsUsecase {
  final AnnouncementsRepo _repo;

  GetMyAnnouncementsUsecase({
    required AnnouncementsRepo repo,
  }) : _repo = repo;

  //* Get All Announcements
  Future<Either<String, AnnouncementEntity>> getMyAnnouncement() =>
      _repo.getAllAnnouncements();
}
