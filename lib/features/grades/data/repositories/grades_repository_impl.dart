//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import 'package:test/features/grades/data/mappers/grade_mappers.dart';
import '../../../../shared/services/exception/error_handler.dart';
import '../../domain/entities/grades_response_entity.dart' show GradesResponseEntity;
import '../../domain/repositories/grades_repository.dart';
import '../datasources/grades_remote_data_source.dart';

//!----------------------------  The Class  -------------------------------------!//

class GradesRepoImp implements GradesRepo {
  final GradesRemote _remote;

  GradesRepoImp({
    required GradesRemote remote,
  }) : _remote = remote;

  @override
  Future<Either<String, GradesResponseEntity>> getMyGrades() {
    return throwAppException(
      () async {
        final result = await _remote.getMyGrades();
        return result.toGradesResponseEntity();
      },
    );
  }
}
