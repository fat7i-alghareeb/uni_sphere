part of 'announcement_bloc.dart';

class AnnouncementState {
  Result<AnnouncementEntity> result;
  Result<AnnouncementEntity> myAnnouncementResult;

  AnnouncementState({
    this.result = const Result.init(),
    this.myAnnouncementResult = const Result.init(),
  });

  AnnouncementState copyWith({
    Result<AnnouncementEntity>? result,
    Result<AnnouncementEntity>? myAnnouncementResult,
  }) {
    return AnnouncementState(
      result: result ?? this.result,
      myAnnouncementResult: myAnnouncementResult ?? this.myAnnouncementResult,
    );
  }
}