//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/timetable_entity.dart';

//!----------------------------  The Class  -------------------------------------!//

abstract class TimetableRepo {
  TimetableRepo();

  //* Get All Timetable
  Future<Either<String, TimetableEntity>> getAllTimetable();
}
