import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/subject_details_entity.dart';
import '../../../domain/usecases/get_subject_details_usecase.dart';

import '../../../../../core/result_builder/result.dart';

part 'subject_details_event.dart';
part 'subject_details_state.dart';

class SubjectDetailsBloc
    extends Bloc<SubjectDetailsEvent, SubjectDetailsState> {
  final GetSubjectDetailsUsecase _getSubjectDetailsUsecase;

  SubjectDetailsBloc(
      {required GetSubjectDetailsUsecase getSubjectDetailsUsecase})
      : _getSubjectDetailsUsecase = getSubjectDetailsUsecase,
        super(SubjectDetailsState()) {
    on<GetSubjectDetailsEvent>(_getSubjectDetails);
  }

  _getSubjectDetails(GetSubjectDetailsEvent event, Emitter emit) async {
    emit(state.copyWith(result: const Result.loading()));
    final response =
        await _getSubjectDetailsUsecase.getSubjectDetails(event.subjectId);
    response.fold(
      (l) => emit(state.copyWith(result: Result.error(error: l))),
      (r) => emit(state.copyWith(result: Result.loaded(data: r))),
    );
  }
}
