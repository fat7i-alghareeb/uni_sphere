import 'package:test/features/grades/domain/entities/grade_entity.dart'
    show GradeEntity;

class GradesResponseEntity {
  const GradesResponseEntity({
    required this.grades,
    required this.numberOfPassedSubjects,
    required this.numberOfFailedSubjects,
    required this.averageGrade,
  });

  final List<GradeEntity> grades;
  final int numberOfPassedSubjects;
  final int numberOfFailedSubjects;
  final double averageGrade;
}
