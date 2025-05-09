import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/features/timetable/domain/entities/month_schedule_entity.dart';

import '../../../../../core/result_builder/result.dart';
import '../../../domain/usecases/timetable_usecase.dart';

part 'time_table_event.dart';
part 'time_table_state.dart';

class TimeTableBloc extends Bloc<TimeTableEvent, TimeTableState> {
  final TimetableUsecase _usecase;
  static int month = 1;
  TimeTableBloc({required TimetableUsecase usecase})
      : _usecase = usecase,
        super(TimeTableState()) {
    on<GetTimeTableEvent>(_getTimeTable);
  }

  _getTimeTable(GetTimeTableEvent event, Emitter emit) async {
    emit(state.copyWith(result: const Result.loading()));
    final response = await _usecase.getTimeTable(month: month);
    response.fold(
      (l) => emit(state.copyWith(result: Result.error(error: l))),
      (r) => emit(state.copyWith(result: Result.loaded(data: r))),
    );
  }
}
