//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/materials_entity.dart';
import '../datasources/materials_remote_data_source.dart';
import '../../domain/repositories/materials_repository.dart';
import '../../../../shared/services/exception/error_handler.dart';

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
