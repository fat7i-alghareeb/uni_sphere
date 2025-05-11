import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/features/timetable/domain/entities/month_schedule_entity.dart';
import '../../../../../core/result_builder/result.dart';
import '../../../../../shared/utils/helper/colored_print.dart';
import '../../../domain/usecases/timetable_usecase.dart';

part 'time_table_event.dart';
part 'time_table_state.dart';

class TimeTableBloc extends Bloc<TimeTableEvent, TimeTableState> {
  final TimetableUsecase _usecase;
  static late DateTime selectedDateTime;
  TimeTableBloc({required TimetableUsecase usecase})
      : _usecase = usecase,
        super(TimeTableState()) {
    on<GetTimeTableEvent>(_getTimeTable);
    on<LoadMonthEvent>(_loadMonthEvent);
  }

  _getTimeTable(GetTimeTableEvent event, Emitter emit) async {
    emit(
      state.copyWith(result: const Result.loading(), monthsSchedules: []),
    );
    final response = await _usecase.getTimeTable(month: event.month);
    response.fold(
      (l) => emit(
        state.copyWith(
          result: Result.error(
            error: l,
          ),
        ),
      ),
      (r) {
        final updatedSchedules =
            List<MonthScheduleEntity>.from(state.monthsSchedules)..add(r);
        selectedDateTime = event.month;
        return emit(
          state.copyWith(
            result: Result.loaded(data: r),
            monthsSchedules: updatedSchedules,
          ),
        );
      },
    );
  }

  _loadMonthEvent(LoadMonthEvent event, Emitter emit) async {
    emit(state.copyWith(loadMonthResult: const Result.loading()));
    printR(event.month);
    final response = await _usecase.getTimeTable(month: event.month);

    response.fold(
      (l) => emit(
        state.copyWith(
          loadMonthResult: Result.error(error: l),
        ),
      ),
      (r) {
        final updatedSchedules =
            List<MonthScheduleEntity>.from(state.monthsSchedules)..add(r);
        selectedDateTime = event.month;
        return emit(
          state.copyWith(
            loadMonthResult: Result.loaded(data: r),
            monthsSchedules: updatedSchedules,
          ),
        );
      },
    );
  }

  MonthScheduleEntity get getMonthsSchedulesByDateTime {
    return state.monthsSchedules.firstWhere(
      (element) => element.month.month == selectedDateTime.month,
      orElse: () => MonthScheduleEntity(
        month: selectedDateTime,
        daysTimeTables: [],
      ),
    );
  }
}
