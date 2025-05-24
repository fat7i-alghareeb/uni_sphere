//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../../../../core/constants/dummy_data.dart';
import '../entities/subject_details_entity.dart';
import '../repositories/subjects_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class GetSubjectDetailsUsecase {
  // ignore: unused_field
  final SubjectsRepo _repo;

  GetSubjectDetailsUsecase({
    required SubjectsRepo repo,
  }) : _repo = repo;

  //* Get Subject Details
  Future<Either<String, SubjectDetailsEntity>> getSubjectDetails(
      String id) async {
    return Future.delayed(
      const Duration(milliseconds: 1250),
      () => Right(
        computerEngineeringSubjectsDetails
            .firstWhere((element) => element.id == id),
      ),
    );
  }
}
