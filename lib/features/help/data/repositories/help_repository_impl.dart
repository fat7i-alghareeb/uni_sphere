//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';

import '../../../../shared/services/exception/error_handler.dart';
import '../../domain/entities/help_entity.dart';
import '../../domain/repositories/help_repository.dart';
import '../datasources/help_remote_data_source.dart';

//!----------------------------  The Class  -------------------------------------!//

class HelpRepoImp implements HelpRepo {
  final HelpRemote _remote;

  HelpRepoImp({
    required HelpRemote remote,
  }) : _remote = remote;

  @override
  Future<Either<String, HelpEntity>> getAllHelp() {
    return throwAppException(
      () async {
        return await _remote.getAllHelp();
      },
    );
  }
}
