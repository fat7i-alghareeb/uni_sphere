//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/addouncements_entity.dart';

//!----------------------------  The Class  -------------------------------------!//

abstract class AddouncementsRepo {
  AddouncementsRepo();

  //* Get All Addouncements
  Future<Either<String, AddouncementsEntity>> getAllAddouncements();
}
