//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';

import '../entities/announcement_entity.dart';

//!----------------------------  The Class  -------------------------------------!//

abstract class AnnouncementsRepo {
  AnnouncementsRepo();

  //* Get All Announcements
  Future<Either<String, AnnouncementEntity>> getAllAnnouncements();
}
