import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/result_builder/result.dart' show Result;
import '../../../../../shared/entities/user.dart';
import '../../../data/models/simple_user.dart' show SimpleUser;
import '../../../data/params/check_one_time_param.dart' show CheckOneTimeParam;
import '../../../data/params/login_param.dart';
import '../../../data/params/register_param.dart';
import '../../../data/usecases/auth_usecases.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecases _useCase;
  static bool isCheckingOneTimeCode = false;
  AuthBloc({required AuthUsecases useCase})
      : _useCase = useCase,
        super(AuthState()) {
    on<LoginEvent>(_login);
    on<RegisterEvent>(_register);
    on<CheckOneTimeCodeEvent>(_checkOneTime);
    on<ResetLoginStateEvent>((event, emit) {
      emit(state.copyWith(loginResult: const Result.init()));
    });
    on<ResetRegisterStateEvent>((event, emit) {
      emit(state.copyWith(registerResult: const Result.init()));
    });
    on<ResetCheckOneTimeCodeStateEvent>((event, emit) {
      emit(state.copyWith(checkOneTimeResult: const Result.init()));
    });
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

  _checkOneTime(CheckOneTimeCodeEvent event, Emitter emit) async {
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
