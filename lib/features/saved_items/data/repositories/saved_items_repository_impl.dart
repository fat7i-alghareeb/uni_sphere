//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';

import '../../../../shared/services/exception/error_handler.dart';
import '../../domain/entities/saved_items_entity.dart';
import '../../domain/repositories/saved_items_repository.dart';
import '../datasources/saved_items_remote_data_source.dart';

//!----------------------------  The Class  -------------------------------------!//

class SavedItemsRepoImp implements SavedItemsRepo {
  final SavedItemsRemote _remote;

  SavedItemsRepoImp({
    required SavedItemsRemote remote,
  }) : _remote = remote;

  @override
  Future<Either<String, SavedItemsEntity>> getAllSavedItems() {
    return throwAppException(
      () async {
        return await _remote.getAllSavedItems();
      },
    );
  }
}
