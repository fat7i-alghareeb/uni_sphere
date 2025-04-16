//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/addouncements_entity.dart';
import '../repositories/addouncements_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class AddouncementsUsecase {
  final AddouncementsRepo _repo;

  AddouncementsUsecase({
    required AddouncementsRepo repo,
  }) : _repo = repo;

  //* Get All Addouncements
  Future<Either<String, AddouncementsEntity>> getAllAddouncements() =>
      _repo.getAllAddouncements();
}
