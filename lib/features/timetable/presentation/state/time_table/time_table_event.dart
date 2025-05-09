part of 'time_table_bloc.dart';

abstract class TimeTableEvent {}

final class GetTimeTableEvent extends TimeTableEvent {
  GetTimeTableEvent();
}