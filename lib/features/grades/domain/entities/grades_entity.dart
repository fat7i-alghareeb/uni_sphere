class GradeEntity {
  final String id;
  final String subjectId;
  final double practicalGrade;
  final double theoreticalGrade;
  GradeEntity({
    required this.id,
    required this.subjectId,
    required this.practicalGrade,
    required this.theoreticalGrade,
  });
  double get finalGrade => practicalGrade + theoreticalGrade;
}
