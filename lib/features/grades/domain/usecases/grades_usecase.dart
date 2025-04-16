//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/grades_entity.dart';
import '../repositories/grades_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class GradesUsecase {
  final GradesRepo _repo;

  GradesUsecase({
    required GradesRepo repo,
  }) : _repo = repo;

  //* Get All Grades
  Future<Either<String, GradesEntity>> getAllGrades() =>
      _repo.getAllGrades();
}
