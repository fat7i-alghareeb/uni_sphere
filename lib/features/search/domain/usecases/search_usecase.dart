//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/search_entity.dart';
import '../repositories/search_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class SearchUsecase {
  final SearchRepo _repo;

  SearchUsecase({
    required SearchRepo repo,
  }) : _repo = repo;

  //* Get All Search
  Future<Either<String, SearchEntity>> getAllSearch() =>
      _repo.getAllSearch();
}
