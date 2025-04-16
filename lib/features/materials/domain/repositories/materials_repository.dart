//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/materials_entity.dart';

//!----------------------------  The Class  -------------------------------------!//

abstract class MaterialsRepo {
  MaterialsRepo();

  //* Get All Materials
  Future<Either<String, MaterialsEntity>> getAllMaterials();
}
