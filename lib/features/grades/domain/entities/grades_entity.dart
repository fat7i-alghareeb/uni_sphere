class GradeEntity {
  final String id;
  final String subjectName;
  final int subjectYear;
  final int subjectSemester;
  final int midTermGrade;
  final int finalTermGrade;
  final bool isPassed;
  GradeEntity({
    required this.id,
    required this.subjectName,
    required this.subjectYear,
    required this.subjectSemester,
    required this.midTermGrade,
    required this.finalTermGrade,
    required this.isPassed,
  });
  int get totalGrade => midTermGrade + finalTermGrade;
}
