//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/subjects_entity.dart';
import '../repositories/subjects_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class SubjectsUsecase {
  final SubjectsRepo _repo;

  SubjectsUsecase({
    required SubjectsRepo repo,
  }) : _repo = repo;

  //* Get All Subjects
  Future<Either<String, SubjectsEntity>> getAllSubjects() =>
      _repo.getAllSubjects();
}
