class TimetableEntity {
  final String subjectName;
  final String lecturerName;
  final DateTime startTime;
  final DateTime endTime;

  TimetableEntity({
    required this.subjectName,
    required this.lecturerName,
    required this.startTime,
    required this.endTime,
  });
}
