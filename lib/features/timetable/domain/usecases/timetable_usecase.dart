//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../../../../core/constants/time_dummy_data.dart';
import '../entities/month_schedule_entity.dart';
import '../repositories/timetable_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class TimetableUsecase {
  final TimetableRepo _repo;

  TimetableUsecase({
    required TimetableRepo repo,
  }) : _repo = repo;

  //* Get All Timetable
  Future<Either<String, MonthScheduleEntity>> getTimeTable(
      {required int month}) {
    return Future.delayed(
      const Duration(milliseconds: 1250),
      () => Right(generateMonthScheduleDummyData[0]),
    );

// return _repo.getAllTimetable();
  }
}
