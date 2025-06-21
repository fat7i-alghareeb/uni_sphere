//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/month_schedule_entity.dart';
import '../repositories/timetable_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class TimetableUsecase {
  // ignore: unused_field
  final TimetableRepo _repo;

  TimetableUsecase({
    required TimetableRepo repo,
  }) : _repo = repo;

  //* Get All Timetable
  Future<Either<String, MonthScheduleEntity>> getMonthTimetable(
      {required int month, required int year}) {
    return _repo.getMonthTimetable(month: month, year: year);
  }

  //* Get All Timetable
  Future<Either<String, MonthScheduleEntity>> getAllTimetables() {
    return _repo.getAllTimetables();
  }
}
