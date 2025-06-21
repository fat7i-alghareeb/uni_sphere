//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';

import '../../../../shared/services/exception/error_handler.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_data_source.dart';

//!----------------------------  The Class  -------------------------------------!//

class ProfileRepoImp implements ProfileRepo {
  final ProfileRemote _remote;

  ProfileRepoImp({
    required ProfileRemote remote,
  }) : _remote = remote;

  @override
  Future<Either<String, ProfileEntity>> getAllProfile() {
    return throwAppException(
      () async {
        return await _remote.getAllProfile();
      },
    );
  }
}
