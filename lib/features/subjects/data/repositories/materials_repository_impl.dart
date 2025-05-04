//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';

import '../../../../shared/services/exception/error_handler.dart';
import '../../domain/entities/materials_entity.dart';
import '../../domain/repositories/materials_repository.dart';
import '../datasources/materials_remote_data_source.dart';

//!----------------------------  The Class  -------------------------------------!//

class MaterialsRepoImp implements MaterialsRepo {
  final MaterialsRemote _remote;

  MaterialsRepoImp({
    required MaterialsRemote remote,
  }) : _remote = remote;

  @override
  Future<Either<String, MaterialEntity>> getAllMaterials() {
    return throwAppException(
      () async {
        return await _remote.getAllMaterials();
      },
    );
  }
}
