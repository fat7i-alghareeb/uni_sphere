//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';

import '../../../../shared/services/exception/error_handler.dart';
import '../../domain/entities/notifications_entity.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../datasources/notifications_remote_data_source.dart';

//!----------------------------  The Class  -------------------------------------!//

class NotificationsRepoImp implements NotificationsRepo {
  final NotificationsRemote _remote;

  NotificationsRepoImp({
    required NotificationsRemote remote,
  }) : _remote = remote;

  @override
  Future<Either<String, NotificationsEntity>> getAllNotifications() {
    return throwAppException(
      () async {
        return await _remote.getAllNotifications();
      },
    );
  }
}
