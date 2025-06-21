//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import 'package:test/features/timetable/data/mappers/schedule_mappers.dart';
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
  Future<Either<String, MonthScheduleEntity>> getMonthTimetable(
      {required int month, required int year}) {
    return throwAppException(
      () async {
        final monthTimetable = await _remote.getMonthTimetable(month: month, year: year);
        return monthTimetable.toEntity();
      },
    );
  }

  @override
  Future<Either<String, MonthScheduleEntity>> getAllTimetables() {
    return throwAppException(
      () async {
        final allTimetables = await _remote.getAllTimetables();
        return allTimetables.toEntity();
      },
    );
  }
}
