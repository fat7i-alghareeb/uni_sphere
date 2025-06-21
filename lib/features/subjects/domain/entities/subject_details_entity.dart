  import 'materials_entity.dart';

class SubjectDetailsEntity {
  final String id;
  final String title;
  final String professorIntro;
  final String professorName;
  final String subjectDescription;
  final String semester;
  final bool isPassed;
  final double? midTermGrade;
  final double? finalGrade;
  final bool canEnroll;
  final bool doesHaveALab;
  final bool isMultipleChoice;
  final List<MaterialEntity> materials;
  final String imageUrl;
  SubjectDetailsEntity({
    required this.id,
    required this.title,
    required this.professorIntro,
    required this.midTermGrade,
    required this.finalGrade,
    required this.professorName,
    required this.subjectDescription,
    required this.semester,
    required this.isPassed,
    required this.canEnroll,
    required this.doesHaveALab,
    required this.isMultipleChoice,
    required this.materials,
    required this.imageUrl,
  });
}
