//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/subjects_entity.dart';
import '../datasources/subjects_remote_data_source.dart';
import '../../domain/repositories/subjects_repository.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class SubjectsRepoImp implements SubjectsRepo {
  final SubjectsRemote _remote;

  SubjectsRepoImp({
    required SubjectsRemote remote,
  }) : _remote = remote;

  @override
  Future<Either<String, SubjectEntity>> getAllSubjects() {
    return throwAppException(
      () async {
        return await _remote.getAllSubjects();
      },
    );
  }
}
