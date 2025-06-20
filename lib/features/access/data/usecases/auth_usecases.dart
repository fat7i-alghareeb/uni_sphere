import 'package:fpdart/fpdart.dart' show Either;
import 'package:test/core/repo/auth_repo/auth_repo.dart';
import 'package:test/features/access/data/params/check_one_time_param.dart';
import 'package:test/shared/entities/user.dart' show User;

import '../models/simple_user.dart' show SimpleUser;
import '../params/login_param.dart' show LoginParam;
import '../params/register_param.dart' show RegisterParam;

class AuthUsecases {
  final AuthRepository _remote;
  AuthUsecases({
    required AuthRepository remote,
  }) : _remote = remote;

  Future<Either<String, User>> login({required LoginParam loginParam}) =>
      _remote.login(loginParam: loginParam);
  Future<Either<String, SimpleUser>> checkOneTimeCode(
          {required CheckOneTimeParam checkOneTimeParam}) =>
      _remote.checkOneTimeCode(checkOneTimeParam: checkOneTimeParam);
  Future<Either<String, User>> register(
          {required RegisterParam registerParam}) =>
      _remote.register(registerParam: registerParam);
}
