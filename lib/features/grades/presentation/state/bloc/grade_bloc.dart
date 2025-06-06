import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/result_builder/result.dart';
import '../../../domain/entities/grades_response_entity.dart' show GradesResponseEntity;
import '../../../domain/usecases/grades_usecase.dart';
part 'grade_event.dart';
part 'grade_state.dart';

class GradeBloc extends Bloc<GradeEvent, GradeState> {
  final GradesUsecase _usecase;

  GradeBloc({required GradesUsecase usecase})
      : _usecase = usecase,
        super(GradeState()) {
    on<GetGradesEvent>(_getGrades);
    
  }

  _getGrades(GetGradesEvent event, Emitter emit) async {
    emit(state.copyWith(result: const Result.loading()));
    final response = await _usecase.getAllGrades();
    response.fold(
      (l) => emit(
        state.copyWith(result: Result.error(error: l)),
      ),
      (r) => emit(
        state.copyWith(result: Result.loaded(data: r)),
      ),
    );
  }
}
