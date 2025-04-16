//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/notifications_entity.dart';

//!----------------------------  The Class  -------------------------------------!//

abstract class NotificationsRepo {
  NotificationsRepo();

  //* Get All Notifications
  Future<Either<String, NotificationsEntity>> getAllNotifications();
}
