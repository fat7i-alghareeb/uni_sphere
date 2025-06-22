//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/news_entity.dart';
import '../repositories/announcements_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class GetMyAnnouncementsUsecase {
  // ignore: unused_field
  final AnnouncementsRepo _repo;

  GetMyAnnouncementsUsecase({
    required AnnouncementsRepo repo,
  }) : _repo = repo;

  //* Get All Announcements
  Future<Either<String, List<NewsEntity>>> getMyAnnouncement() =>
      _repo.getStudentAnnouncements();
}
