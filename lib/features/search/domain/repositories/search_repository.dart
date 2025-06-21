//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';

import '../entities/search_entity.dart';

//!----------------------------  The Class  -------------------------------------!//

abstract class SearchRepo {
  SearchRepo();

  //* Get All Search
  Future<Either<String, SearchEntity>> getAllSearch();
}
