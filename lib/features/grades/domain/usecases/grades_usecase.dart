//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import 'package:test/features/grades/domain/entities/grades_response_entity.dart' show GradesResponseEntity;

import '../repositories/grades_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class GradesUsecase {
  final GradesRepo _repo;

  GradesUsecase({
    required GradesRepo repo,
  }) : _repo = repo;

  //* Get All Grades
  Future<Either<String, GradesResponseEntity>> getMyGrades() => _repo.getMyGrades();
}
