//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';

import '../entities/news_entity.dart';

//!----------------------------  The Class  -------------------------------------!//

abstract class AnnouncementsRepo {
  AnnouncementsRepo();

  //* Get All Announcements
  Future<Either<String, NewsEntity>> getAllAnnouncements();
}
