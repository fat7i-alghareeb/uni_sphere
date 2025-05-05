part of 'subjects_bloc.dart';

class SubjectsState {
  Result<List<SubjectEntity>> result;

  SubjectsState({
    this.result = const Result.init(),
  });

  SubjectsState copyWith({
    Result<List<SubjectEntity>>? result,
  }) {
    return SubjectsState(
      result: result ?? this.result,
    );
  }
}
