//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/notifications_entity.dart';
import '../repositories/notifications_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class NotificationsUsecase {
  final NotificationsRepo _repo;

  NotificationsUsecase({
    required NotificationsRepo repo,
  }) : _repo = repo;

  //* Get All Notifications
  Future<Either<String, NotificationsEntity>> getAllNotifications() =>
      _repo.getAllNotifications();
}
