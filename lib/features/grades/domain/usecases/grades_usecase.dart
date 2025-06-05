//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../../../../core/constants/dummy_data.dart' show mockedGrades;
import '../entities/grades_entity.dart';
import '../repositories/grades_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class GradesUsecase {
  // ignore: unused_field
  final GradesRepo _repo;

  GradesUsecase({
    required GradesRepo repo,
  }) : _repo = repo;

  //* Get All Grades
  Future<Either<String, List<GradeEntity>>> getAllGrades() => Future.delayed(
        const Duration(seconds: 2),
        () => right(mockedGrades),
      );
}
