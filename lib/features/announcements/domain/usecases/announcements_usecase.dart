//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';

import '../../../../core/constants/dummy_data.dart';
import '../entities/announcement_entity.dart';
import '../repositories/announcements_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class AnnouncementsUsecase {
  // ignore: unused_field
  final AnnouncementsRepo _repo;

  AnnouncementsUsecase({
    required AnnouncementsRepo repo,
  }) : _repo = repo;

  //* Get All Announcements
  Future<Either<String, List<AnnouncementEntity>>> getAllAnnouncements() =>
      Future.delayed(
        const Duration(milliseconds: 1200),
        () => Right(fullAnnouncements),
      );
  // _repo.getAllAnnouncements();
}
