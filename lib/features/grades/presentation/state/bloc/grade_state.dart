part of 'grade_bloc.dart';

class GradeState {
  Result<GradesResponseEntity> result;

  GradeState({
    this.result = const Result.init(),
  });

  GradeState copyWith({
    Result<GradesResponseEntity>? result,
  }) {
    return GradeState(
      result: result ?? this.result,
    );
  }
}