import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/features/subjects/domain/entities/subject_entity.dart';
import 'package:test/features/subjects/domain/usecases/get_year_subjects_usecase.dart';

import '../../../../../core/result_builder/result.dart';
import '../../../domain/usecases/subjects_usecase.dart';

part 'subjects_event.dart';
part 'subjects_state.dart';

class SubjectsBloc extends Bloc<SubjectsEvent, SubjectsState> {
  final SubjectsUsecase _usecase;
  final GetYearSubjectsUsecase _getYearSubjectsUsecase;

  SubjectsBloc({
    required SubjectsUsecase usecase,
    required GetYearSubjectsUsecase getYearSubjectsUsecase,
  })  : _usecase = usecase,
        _getYearSubjectsUsecase = getYearSubjectsUsecase,
        super(const SubjectsState()) {
    on<GetSubjectsEvent>(_getSubjects);
    on<GetYearSubjectsEvent>(_getYearSubjects);
    on<UpdateSelectedYearEvent>(_updateSelectedYear);
  }

  void updateSelectedYear(int year) {
    add(UpdateSelectedYearEvent(year));
  }

  void _updateSelectedYear(UpdateSelectedYearEvent event, Emitter emit) {
    emit(state.copyWith(selectedYear: event.year));
  }

  void _getSubjects(GetSubjectsEvent event, Emitter emit) async {
    emit(state.copyWith(result: const Result.loading()));
    final response = await _usecase.getAllSubjects();
    response.fold(
      (l) => emit(state.copyWith(result: Result.error(error: l))),
      (r) => emit(state.copyWith(result: Result.loaded(data: r))),
    );
  }

  void _getYearSubjects(GetYearSubjectsEvent event, Emitter emit) async {
    emit(state.copyWith(yearResult: const Result.loading()));
    final response = await _getYearSubjectsUsecase.getYearSubjects(event.year);
    response.fold(
      (l) => emit(state.copyWith(yearResult: Result.error(error: l))),
      (r) => emit(state.copyWith(yearResult: Result.loaded(data: r))),
    );
  }
}
