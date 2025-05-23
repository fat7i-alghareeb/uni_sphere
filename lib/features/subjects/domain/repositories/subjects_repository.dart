//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';

import '../entities/subject_entity.dart';

//!----------------------------  The Class  -------------------------------------!//

abstract class SubjectsRepo {
  SubjectsRepo();

  //* Get All Subjects
  Future<Either<String, List<SubjectEntity>>> getAllSubjects();
}
