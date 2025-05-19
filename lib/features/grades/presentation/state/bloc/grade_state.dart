part of 'grade_bloc.dart';

class GradeState {
  Result<GradeEntity> result;

  GradeState({
    this.result = const Result.init(),
  });

  GradeState copyWith({
    Result<GradeEntity>? result,
  }) {
    return GradeState(
      result: result ?? this.result,
    );
  }
}