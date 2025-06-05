part of 'announcement_bloc.dart';

class AnnouncementState {
  Result<List<NewsEntity>> result;
  Result<List<NewsEntity>> myAnnouncementResult;

  AnnouncementState({
    this.result = const Result.init(),
    this.myAnnouncementResult = const Result.init(),
  });

  AnnouncementState copyWith({
    Result<List<NewsEntity>>? result,
    Result<List<NewsEntity>>? myAnnouncementResult,
  }) {
    return AnnouncementState(
      result: result ?? this.result,
      myAnnouncementResult: myAnnouncementResult ?? this.myAnnouncementResult,
    );
  }
}
