
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/features/subjects/domain/entities/subjects_entity.dart';

import '../../../../../core/result_builder/result.dart';
import '../../../domain/usecases/subjects_usecase.dart';

part 'subjects_event.dart';
part 'subjects_state.dart';

class SubjectsBloc extends Bloc<SubjectsEvent, SubjectsState> {
  final SubjectsUsecase _usecase;

  SubjectsBloc({required SubjectsUsecase usecase})
      : _usecase = usecase,
        super(SubjectsState()) {
    on<GetSubjectsEvent>(_getSubjects);
  }

  _getSubjects(GetSubjectsEvent event, Emitter emit) async {
    emit(state.copyWith(result: const Result.loading()));
    final response = await _usecase.getAllSubjects();
    response.fold(
      (l) => emit(state.copyWith(result: Result.error(error: l))),
      (r) => emit(state.copyWith(result: Result.loaded(data: r))),
    );
  }
}
