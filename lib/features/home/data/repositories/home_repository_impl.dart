//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';

import '../../../../shared/services/exception/error_handler.dart';
import '../../domain/entities/home_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_data_source.dart';

//!----------------------------  The Class  -------------------------------------!//

class HomeRepoImp implements HomeRepo {
  final HomeRemote _remote;

  HomeRepoImp({
    required HomeRemote remote,
  }) : _remote = remote;

  @override
  Future<Either<String, HomeEntity>> getAllHome() {
    return throwAppException(
      () async {
        return await _remote.getAllHome();
      },
    );
  }
}
