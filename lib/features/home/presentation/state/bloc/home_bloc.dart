
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/features/home/domain/entities/home_entity.dart';
import '../../../../../core/result_builder/result.dart';
import '../../../domain/usecases/home_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUsecase _useCase;

  HomeBloc({required HomeUsecase useCase})
      : _useCase = useCase,
        super(HomeState()) {
    on<GetHomeEvent>(_getHome);
  }

  _getHome(GetHomeEvent event, Emitter emit) async {
    emit(state.copyWith(result: const Result.loading()));
    final response = await _useCase.getAllHome();
    response.fold(
      (l) => emit(state.copyWith(result: Result.error(error: l))),
      (r) => emit(state.copyWith(result: Result.loaded(data: r))),
    );
  }
}