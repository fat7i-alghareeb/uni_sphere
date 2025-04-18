class SubjectEntity {
  final String id;
  final String title;
  final String professorName;
  final String year;
  final String semester;
  final bool isPassed;
  final bool canEnroll;
  SubjectEntity({
    required this.id,
    required this.title,
    required this.professorName,
    required this.year,
    required this.semester,
    required this.isPassed,
    required this.canEnroll,
  });
}
