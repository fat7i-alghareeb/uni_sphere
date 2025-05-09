part of 'subject_details_bloc.dart';

abstract class SubjectDetailsEvent {}

final class GetSubjectDetailsEvent extends SubjectDetailsEvent {
  final String subjectId;
  GetSubjectDetailsEvent({required this.subjectId});
}