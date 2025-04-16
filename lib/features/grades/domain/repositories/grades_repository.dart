//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/grades_entity.dart';

//!----------------------------  The Class  -------------------------------------!//

abstract class GradesRepo {
  GradesRepo();

  //* Get All Grades
  Future<Either<String, GradesEntity>> getAllGrades();
}
