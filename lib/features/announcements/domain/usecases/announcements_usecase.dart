//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/announcement_entity.dart';
import '../repositories/announcements_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class AnnouncementsUsecase {
  final AnnouncementsRepo _repo;

  AnnouncementsUsecase({
    required AnnouncementsRepo repo,
  }) : _repo = repo;

  //* Get All Announcements
  Future<Either<String, AnnouncementEntity>> getAllAnnouncements() =>
      _repo.getAllAnnouncements();
}
