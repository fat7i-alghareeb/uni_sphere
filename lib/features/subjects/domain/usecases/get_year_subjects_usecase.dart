//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/subject_entity.dart';
import '../repositories/subjects_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class GetYearSubjectsUsecase {
  // ignore: unused_field
  final SubjectsRepo _repo;

  GetYearSubjectsUsecase({
    required SubjectsRepo repo,
  }) : _repo = repo;

  //* Get All Subjects
  Future<Either<String, List<SubjectEntity>>> getYearSubjects(int year) async {
    return _repo.getMajorSubjectByYear(year);
  }
}
