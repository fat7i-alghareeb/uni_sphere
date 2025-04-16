import 'materials_entity.dart';

class SubjectDetailsEntity {
  final String id;
  final String title;
  final String professorIntro;
  final String professorName;
  final String semester;
  final bool isPassed;
  final bool canEnroll;
  final List<MaterialEntity> materials;
  SubjectDetailsEntity({
    required this.id,
    required this.title,
    required this.professorIntro,
    required this.professorName,
    required this.semester,
    required this.isPassed,
    required this.canEnroll,
    required this.materials,
  });
}
