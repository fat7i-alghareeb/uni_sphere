//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import '../entities/help_entity.dart';

//!----------------------------  The Class  -------------------------------------!//

abstract class HelpRepo {
  HelpRepo();

  //* Get All Help
  Future<Either<String, HelpEntity>> getAllHelp();
}
