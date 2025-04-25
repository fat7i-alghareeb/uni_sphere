//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/announcement_entity.dart';

//!----------------------------  The Class  -------------------------------------!//

abstract class AddouncementsRepo {
  AddouncementsRepo();

  //* Get All Addouncements
  Future<Either<String, AnnouncementEntity>> getAllAddouncements();
}
