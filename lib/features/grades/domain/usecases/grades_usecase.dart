//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../../../../core/constants/dummy_data.dart' show mockedGradesResponse;
import '../entities/grades_response_entity.dart' show GradesResponseEntity;
import '../repositories/grades_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class GradesUsecase {
  // ignore: unused_field
  final GradesRepo _repo;

  GradesUsecase({
    required GradesRepo repo,
  }) : _repo = repo;

  //* Get All Grades
  Future<Either<String, GradesResponseEntity>> getAllGrades() => Future.delayed(
        const Duration(seconds: 2),
        () => right(mockedGradesResponse),
      );
}
