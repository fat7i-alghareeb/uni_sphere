part of 'subject_details_bloc.dart';

class SubjectDetailsState {
  Result<SubjectDetailsEntity> result;

  SubjectDetailsState({
    this.result = const Result.init(),
  });

  SubjectDetailsState copyWith({
    Result<SubjectDetailsEntity>? result,
  }) {
    return SubjectDetailsState(
      result: result ?? this.result,
    );
  }
}
