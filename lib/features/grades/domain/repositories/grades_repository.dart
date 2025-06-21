//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';

import '../entities/grade_entity.dart';

//!----------------------------  The Class  -------------------------------------!//

abstract class GradesRepo {
  GradesRepo();

  //* Get All Grades
  Future<Either<String, GradeEntity>> getAllGrades();
}
