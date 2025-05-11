//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import 'package:test/shared/utils/helper/colored_print.dart';
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
      {required DateTime month}) {
    return Future.delayed(
      const Duration(milliseconds: 1250),
      () => Right(
        generateMonthScheduleDummyData.firstWhere(
          (element) => element.month.month == month.month,
          orElse: () => MonthScheduleEntity(
            month: DateTime.now(),
            daysTimeTables: [],
          ),
        ),
      ),
    );

// return _repo.getAllTimetable();
  }
}
