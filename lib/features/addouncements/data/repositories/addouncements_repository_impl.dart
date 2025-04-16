//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/addouncements_entity.dart';
import '../datasources/addouncements_remote_data_source.dart';
import '../../domain/repositories/addouncements_repository.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class AddouncementsRepoImp implements AddouncementsRepo {
  final AddouncementsRemote _remote;

  AddouncementsRepoImp({
    required AddouncementsRemote remote,
  }) : _remote = remote;

  @override
  Future<Either<String, AddouncementsEntity>> getAllAddouncements() {
    return throwAppException(
      () async {
        return await _remote.getAllAddouncements();
      },
    );
  }
}
