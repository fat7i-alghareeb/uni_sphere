//!----------------------------  Imports  -------------------------------------!//
import 'package:fpdart/fpdart.dart';
import 'package:test/core/constants/dummy_data.dart';

import '../entities/home_entity.dart';
import '../repositories/home_repository.dart';

//!----------------------------  The Class  -------------------------------------!//

class HomeUsecase {
  // ignore: unused_field
  final HomeRepo _repo;

  HomeUsecase({
    required HomeRepo repo,
  }) : _repo = repo;

  //* Get All Home
  Future<Either<String, HomeEntity>> getAllHome() => Future.delayed(
        const Duration(milliseconds: 1250),
        () => Right(mockedHomeData),
      );
}
