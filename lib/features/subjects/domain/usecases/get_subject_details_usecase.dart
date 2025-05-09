//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../repositories/subjects_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class GetSubjectDetailsUsecase {
  final SubjectsRepo _repo;

  GetSubjectDetailsUsecase({
    required SubjectsRepo repo,
  }) : _repo = repo;

  //* Get Subject Details
  Future<Either<String, String>> getSubjectDetails(String id) async {
    return const Right("fathi");
  }
}
