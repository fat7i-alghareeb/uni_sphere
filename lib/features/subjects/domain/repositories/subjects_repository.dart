//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';

import '../entities/subjects_entity.dart';

//!----------------------------  The Class  -------------------------------------!//

abstract class SubjectsRepo {
  SubjectsRepo();

  //* Get All Subjects
  Future<Either<String, SubjectEntity>> getAllSubjects();
}
