//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';

import '../../../../shared/services/exception/error_handler.dart';
import '../../domain/entities/subject_entity.dart';
import '../../domain/repositories/subjects_repository.dart';
import '../datasources/subjects_remote_data_source.dart';

//!----------------------------  The Class  -------------------------------------!//

class SubjectsRepoImp implements SubjectsRepo {
  final SubjectsRemote _remote;

  SubjectsRepoImp({
    required SubjectsRemote remote,
  }) : _remote = remote;

  @override
  Future<Either<String, List<SubjectEntity>>> getAllSubjects() {
    return throwAppException(
      () async {
        return await _remote.getAllSubjects();
      },
    );
  }
}
