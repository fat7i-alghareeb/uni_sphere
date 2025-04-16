//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/saved_items_entity.dart';

//!----------------------------  The Class  -------------------------------------!//

abstract class SavedItemsRepo {
  SavedItemsRepo();

  //* Get All SavedItems
  Future<Either<String, SavedItemsEntity>> getAllSavedItems();
}
