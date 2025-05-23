//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';

import '../../../../core/constants/dummy_data.dart';
import '../entities/subject_entity.dart';
import '../repositories/subjects_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class SubjectsUsecase {
  // ignore: unused_field
  final SubjectsRepo _repo;

  SubjectsUsecase({
    required SubjectsRepo repo,
  }) : _repo = repo;

  //* Get All Subjects
  Future<Either<String, List<SubjectEntity>>> getAllSubjects() =>
      Future.delayed(
        const Duration(milliseconds: 1250),
        () => Right(computerEngineeringSubjects),
      );
}
