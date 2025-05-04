//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';

import '../entities/materials_entity.dart';
import '../repositories/materials_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class MaterialsUsecase {
  final MaterialsRepo _repo;

  MaterialsUsecase({
    required MaterialsRepo repo,
  }) : _repo = repo;

  //* Get All Materials
  Future<Either<String, MaterialEntity>> getAllMaterials() =>
      _repo.getAllMaterials();
}
