//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import 'package:test/features/subjects/domain/entities/subject_details_entity.dart'
    show SubjectDetailsEntity;

import '../entities/subject_entity.dart';

//!----------------------------  The Class  -------------------------------------!//

abstract class SubjectsRepo {
  SubjectsRepo();

  //* Get All Subjects
  Future<Either<String, List<SubjectEntity>>> getMajorSubjectByYear(int year);

  //* Get My Subjects
  Future<Either<String, List<SubjectEntity>>> getMySubjects();

  //* Get Subject By Id
  Future<Either<String, SubjectDetailsEntity>> getSubjectById(String id);
}
