//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/announcement_entity.dart';
import '../repositories/addouncements_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class AddouncementsUsecase {
  final AddouncementsRepo _repo;

  AddouncementsUsecase({
    required AddouncementsRepo repo,
  }) : _repo = repo;

  //* Get All Addouncements
  Future<Either<String, AnnouncementEntity>> getAllAddouncements() =>
      _repo.getAllAddouncements();
}
