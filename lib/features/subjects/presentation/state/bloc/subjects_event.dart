part of 'subjects_bloc.dart';

abstract class SubjectsEvent {}

final class GetSubjectsEvent extends SubjectsEvent {
  GetSubjectsEvent();
}

final class GetYearSubjectsEvent extends SubjectsEvent {
  final int year;
  GetYearSubjectsEvent(this.year);
}

class UpdateSelectedYearEvent extends SubjectsEvent {
  final int year;

  UpdateSelectedYearEvent(this.year);
}
