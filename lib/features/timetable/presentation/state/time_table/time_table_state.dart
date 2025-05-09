part of 'time_table_bloc.dart';

class TimeTableState {
  Result<MonthScheduleEntity> result;

  TimeTableState({
    this.result = const Result.init(),
  });

  TimeTableState copyWith({
    Result<MonthScheduleEntity>? result,
  }) {
    return TimeTableState(
      result: result ?? this.result,
    );
  }
}