//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/help_entity.dart';
import '../repositories/help_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class HelpUsecase {
  final HelpRepo _repo;

  HelpUsecase({
    required HelpRepo repo,
  }) : _repo = repo;

  //* Get All Help
  Future<Either<String, HelpEntity>> getAllHelp() =>
      _repo.getAllHelp();
}
