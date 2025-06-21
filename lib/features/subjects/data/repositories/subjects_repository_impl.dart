//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import 'package:test/features/subjects/data/mappers/subject_mapper.dart';

import '../../../../shared/services/exception/error_handler.dart';
import '../../domain/entities/subject_details_entity.dart'
    show SubjectDetailsEntity;
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
  Future<Either<String, List<SubjectEntity>>> getMajorSubjectByYear(
    int year,
  ) {
    return throwAppException(
      () async {
        final response = await _remote.getMySubjectsByYear(year);
        final subjects =
            response.subjects.map((subject) => subject.toEntity()).toList();
        return subjects;
      },
    );
  }

  @override
  Future<Either<String, List<SubjectEntity>>> getMySubjects() {
    return throwAppException(
      () async {
        final response = await _remote.getMySubjects();
        final subjects =
            response.subjects.map((subject) => subject.toEntity()).toList();
        return subjects;
      },
    );
  }

  @override
  Future<Either<String, SubjectDetailsEntity>> getSubjectById(String id) {
    return throwAppException(
      () async {
        final response = await _remote.getSubjectById(id);
        final subject = response.toEntity();
        return subject;
      },
    );
  }
}
