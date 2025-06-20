import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/core/result_builder/result.dart' show Result;
import 'package:test/features/access/data/params/login_param.dart';
import 'package:test/features/access/data/usecases/auth_usecases.dart';
import 'package:test/shared/entities/user.dart';

import '../../../data/models/simple_user.dart' show SimpleUser;
import '../../../data/params/check_one_time_param.dart' show CheckOneTimeParam;
import '../../../data/params/register_param.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecases _useCase;
  AuthBloc({required AuthUsecases useCase})
      : _useCase = useCase,
        super(AuthState()) {
    on<LoginEvent>(_login);
    on<RegisterEvent>(_register);
    on<CheckOneTimeEvent>(_checkOneTime);
  }

  _login(LoginEvent event, Emitter emit) async {
    emit(state.copyWith(loginResult: const Result.loading()));
    final response = await _useCase.login(loginParam: event.loginParam);
    response.fold(
      (l) => emit(
        state.copyWith(
          loginResult: Result.error(error: l),
        ),
      ),
      (r) => emit(
        state.copyWith(
          loginResult: Result.loaded(data: r),
        ),
      ),
    );
  }

  _register(RegisterEvent event, Emitter emit) async {
    emit(state.copyWith(registerResult: const Result.loading()));
    final response =
        await _useCase.register(registerParam: event.registerParam);
    response.fold(
      (l) => emit(
        state.copyWith(
          registerResult: Result.error(error: l),
        ),
      ),
      (r) => emit(
        state.copyWith(
          registerResult: Result.loaded(data: r),
        ),
      ),
    );
  }

  _checkOneTime(CheckOneTimeEvent event, Emitter emit) async {
    emit(state.copyWith(checkOneTimeResult: const Result.loading()));
    final response = await _useCase.checkOneTimeCode(
        checkOneTimeParam: event.checkOneTimeParam);
    response.fold(
      (l) => emit(
        state.copyWith(
          checkOneTimeResult: Result.error(error: l),
        ),
      ),
      (r) => emit(
        state.copyWith(
          checkOneTimeResult: Result.loaded(data: r),
        ),
      ),
    );
  }
}
