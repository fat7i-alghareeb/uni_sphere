part of 'subjects_bloc.dart';

class SubjectsState {
  final Result<List<SubjectEntity>> result;
  final Result<List<SubjectEntity>> yearResult;
  final int selectedYear;
  final String? subjectIdForNavigation;

  const SubjectsState({
    this.result = const Result.init(),
    this.yearResult = const Result.init(),
    this.selectedYear = -1,
    this.subjectIdForNavigation,
  });

  SubjectsState copyWith({
    Result<List<SubjectEntity>>? result,
    Result<List<SubjectEntity>>? yearResult,
    int? selectedYear,
    String? subjectIdForNavigation,
  }) {
    return SubjectsState(
      result: result ?? this.result,
      yearResult: yearResult ?? this.yearResult,
      selectedYear: selectedYear ?? this.selectedYear,
      subjectIdForNavigation:
          subjectIdForNavigation ?? this.subjectIdForNavigation,
    );
  }
}
