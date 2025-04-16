//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/search_entity.dart';
import '../datasources/search_remote_data_source.dart';
import '../../domain/repositories/search_repository.dart';
import '../../../../shared/services/exception/error_handler.dart';

//!----------------------------  The Class  -------------------------------------!//

class SearchRepoImp implements SearchRepo {
  final SearchRemote _remote;

  SearchRepoImp({
    required SearchRemote remote,
  }) : _remote = remote;

  @override
  Future<Either<String, SearchEntity>> getAllSearch() {
    return throwAppException(
      () async {
        return await _remote.getAllSearch();
      },
    );
  }
}
