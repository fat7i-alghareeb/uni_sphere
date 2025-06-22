import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/news_entity.dart';

import '../../../../../core/result_builder/result.dart';
import '../../../domain/usecases/announcements_usecase.dart';
import '../../../domain/usecases/get_my_announcements_usecase.dart';

part 'announcement_event.dart';
part 'announcement_state.dart';

class AnnouncementBloc extends Bloc<AnnouncementEvent, AnnouncementState> {
  final AnnouncementsUsecase _usecase;
  final GetMyAnnouncementsUsecase _getMyAnnouncementsUsecase;
  AnnouncementBloc({
    required AnnouncementsUsecase usecase,
    required GetMyAnnouncementsUsecase getMyAnnouncementsUsecase,
  })  : _usecase = usecase,
        _getMyAnnouncementsUsecase = getMyAnnouncementsUsecase,
        super(AnnouncementState()) {
    on<GetAnnouncementEvent>(_getAnnouncement);
    on<GetMyAnnouncementEvent>(_getMyAnnouncement);
  }

  _getAnnouncement(GetAnnouncementEvent event, Emitter emit) async {
    emit(state.copyWith(result: const Result.loading()));
    final response = await _usecase.getFacultyAnnouncements();
    response.fold(
      (l) => emit(
        state.copyWith(
          result: Result.error(error: l),
        ),
      ),
      (r) => emit(
        state.copyWith(
          result: Result.loaded(data: r),
        ),
      ),
    );
  }

  _getMyAnnouncement(GetMyAnnouncementEvent event, Emitter emit) async {
    emit(state.copyWith(myAnnouncementResult: const Result.loading()));
    final response = await _getMyAnnouncementsUsecase.getMyAnnouncement();
    response.fold(
      (l) => emit(
        state.copyWith(
          myAnnouncementResult: Result.error(error: l),
        ),
      ),
      (r) => emit(
        state.copyWith(
          myAnnouncementResult: Result.loaded(data: r),
        ),
      ),
    );
  }
}
