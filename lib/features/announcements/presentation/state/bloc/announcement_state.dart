part of 'announcement_bloc.dart';

class AnnouncementState {
  Result<List<AnnouncementEntity>> result;
  Result<List<AnnouncementEntity>> myAnnouncementResult;

  AnnouncementState({
    this.result = const Result.init(),
    this.myAnnouncementResult = const Result.init(),
  });

  AnnouncementState copyWith({
    Result<List<AnnouncementEntity>>? result,
    Result<List<AnnouncementEntity>>? myAnnouncementResult,
  }) {
    return AnnouncementState(
      result: result ?? this.result,
      myAnnouncementResult: myAnnouncementResult ?? this.myAnnouncementResult,
    );
  }
}