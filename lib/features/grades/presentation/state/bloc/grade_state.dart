part of 'grade_bloc.dart';

class GradeState {
  Result<List<GradeEntity>> result;

  GradeState({
    this.result = const Result.init(),
  });

  GradeState copyWith({
    Result<List<GradeEntity>>? result,
  }) {
    return GradeState(
      result: result ?? this.result,
    );
  }
}