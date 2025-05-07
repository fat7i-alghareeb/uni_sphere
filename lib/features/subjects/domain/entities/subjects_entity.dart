class SubjectEntity {
  final String id;
  final String title; //
  final String professorName; //
  final int year; // 1
  final String semester; // 2
  final bool isPassed; //
  final bool canEnroll; //
  final int? midTermGrade;//
  final int? finalGrade;//
  final bool isMultipleChoice;// 3
  final bool doesHaveALab;// 4 
  final String imageUrl;
  SubjectEntity({
    required this.id,
    required this.title,
    required this.professorName,
    required this.year,
    required this.semester,
    required this.isPassed,
    required this.canEnroll,
    this.midTermGrade,
    this.finalGrade,
    required this.isMultipleChoice,
    required this.doesHaveALab,
    required this.imageUrl,
  });

  get totalGrade {
    return (midTermGrade ?? 0) + (finalGrade ?? 0);
  }
}
