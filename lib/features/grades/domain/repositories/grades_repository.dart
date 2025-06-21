//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import 'package:test/features/grades/domain/entities/grades_response_entity.dart' show GradesResponseEntity;

//!----------------------------  The Class  -------------------------------------!//

abstract class GradesRepo {
  GradesRepo();

  //* Get All Grades
  Future<Either<String, GradesResponseEntity>> getMyGrades();
} 
