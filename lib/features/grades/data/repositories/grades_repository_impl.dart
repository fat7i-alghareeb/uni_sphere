//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';

import '../../../../shared/services/exception/error_handler.dart';
import '../../domain/entities/grade_entity.dart';
import '../../domain/repositories/grades_repository.dart';
import '../datasources/grades_remote_data_source.dart';

//!----------------------------  The Class  -------------------------------------!//

class GradesRepoImp implements GradesRepo {
  final GradesRemote _remote;

  GradesRepoImp({
    required GradesRemote remote,
  }) : _remote = remote;

  @override
  Future<Either<String, GradeEntity>> getAllGrades() {
    return throwAppException(
      () async {
        return await _remote.getAllGrades();
      },
    );
  }
}
