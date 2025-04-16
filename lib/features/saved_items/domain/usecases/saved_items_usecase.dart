//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/saved_items_entity.dart';
import '../repositories/saved_items_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class SavedItemsUsecase {
  final SavedItemsRepo _repo;

  SavedItemsUsecase({
    required SavedItemsRepo repo,
  }) : _repo = repo;

  //* Get All SavedItems
  Future<Either<String, SavedItemsEntity>> getAllSavedItems() =>
      _repo.getAllSavedItems();
}
