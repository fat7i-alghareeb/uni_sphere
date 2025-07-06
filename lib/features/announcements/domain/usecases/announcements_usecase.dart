//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';

import '../entities/news_entity.dart';
import '../repositories/announcements_repository.dart';
//!----------------------------  The Class  -------------------------------------!//

class AnnouncementsUsecase {
  // ignore: unused_field
  final AnnouncementsRepo _repo;

  AnnouncementsUsecase({
    required AnnouncementsRepo repo,
  }) : _repo = repo;

  Future<Either<String, List<NewsEntity>>> getFacultyAnnouncements() =>
      _repo.getFacultyAnnouncements();
}
