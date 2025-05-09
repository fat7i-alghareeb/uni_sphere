//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/month_schedule_entity.dart';
import '../datasources/timetable_remote_data_source.dart';
import '../../domain/repositories/timetable_repository.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class TimetableRepoImp implements TimetableRepo {
  final TimetableRemote _remote;

  TimetableRepoImp({
    required TimetableRemote remote,
  }) : _remote = remote;

  @override
  Future<Either<String, MonthScheduleEntity>> getAllTimetable() {
    return throwAppException(
      () async {
        return await _remote.getAllTimetable();
      },
    );
  }
}
