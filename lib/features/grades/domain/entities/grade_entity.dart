class GradeEntity {
  final String subjectName;
  final int subjectYear;
  final int subjectSemester;
  final double midTermGrade;
  final double? finalTermGrade;
  final bool isPassed;
  GradeEntity({
    required this.subjectName,
    required this.subjectYear,
    required this.subjectSemester,
    required this.midTermGrade,
    required this.finalTermGrade,
    required this.isPassed,
  });
  double get totalGrade => midTermGrade + (finalTermGrade ?? 0);
}
