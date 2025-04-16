//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/timetable_entity.dart';
import '../repositories/timetable_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class TimetableUsecase {
  final TimetableRepo _repo;

  TimetableUsecase({
    required TimetableRepo repo,
  }) : _repo = repo;

  //* Get All Timetable
  Future<Either<String, TimetableEntity>> getAllTimetable() =>
      _repo.getAllTimetable();
}
