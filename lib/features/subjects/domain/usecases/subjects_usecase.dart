//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/subject_entity.dart';
import '../repositories/subjects_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class SubjectsUsecase {
  // ignore: unused_field
  final SubjectsRepo _repo;

  SubjectsUsecase({
    required SubjectsRepo repo,
  }) : _repo = repo;

  //* Get My Subjects
  Future<Either<String, List<SubjectEntity>>> getMySubjects() =>
      _repo.getMySubjects();
}
