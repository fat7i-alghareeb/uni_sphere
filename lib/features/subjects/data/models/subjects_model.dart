import 'materials_model.dart';

class SubjectsModel {
  final List<Subject> subjects;

  SubjectsModel({
    required this.subjects,
  });

  factory SubjectsModel.fromMap(Map<String, dynamic> map) {
    return SubjectsModel(
      subjects: (map['subjects'] as List<dynamic>)
          .map((e) => Subject.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Subject {
  final String id;
  final String majorId;
  final String name;
  final String professorName;
  final int year;
  final double? midTermGrade;
  final double? finalGrade;
  final bool isPassed;
  final bool canEnroll;
  final bool isMultipleChoice;
  final bool doesHaveALab;
  final int semester;
  final String imageUrl;

  Subject({
    required this.id,
    required this.majorId,
    required this.name,
    required this.professorName,
    required this.year,
    required this.midTermGrade,
    required this.finalGrade,
    required this.isPassed,
    required this.canEnroll,
    required this.isMultipleChoice,
    required this.doesHaveALab,
    required this.semester,
    required this.imageUrl,
  });

  factory Subject.fromMap(Map<String, dynamic> map) {
    return Subject(
      id: map['id'] as String,
      majorId: map['majorId'] as String,
      name: map['name'] as String,
      professorName: map['professorName'] as String,
      year: map['year'] as int,
      midTermGrade: map['midTermGrade'] as double?,
      finalGrade: map['finalGrade'] as double?,
      isPassed: map['isPassed'] as bool,
      canEnroll: map['canEnroll'] as bool,
      isMultipleChoice: map['isMultipleChoice'] as bool,
      doesHaveALab: map['doesHaveALab'] as bool,
      semester: map['semester'] as int,
      imageUrl: map['imageUrl'] as String? ?? "",
    );
  }
}

class SubjectById {
  final String id;
  final String majorId;
  final String name;
  final String professorName;
  final int year;
  final double? midTermGrade;
  final double? finalGrade;
  final bool isPassed;
  final bool canEnroll;
  final bool isMultipleChoice;
  final bool doesHaveALab;
  final int semester;
  final String imageUrl;
  final List<MaterialsModel> materials;

  SubjectById({
    required this.id,
    required this.majorId,
    required this.name,
    required this.professorName,
    required this.year,
    required this.semester,
    required this.isPassed,
    required this.canEnroll,
    required this.midTermGrade,
    required this.finalGrade,
    required this.isMultipleChoice,
    required this.doesHaveALab,
    required this.imageUrl,
    required this.materials,
  });

  factory SubjectById.fromMap(Map<String, dynamic> map) {
    return SubjectById(
      id: map['id'] as String,
      majorId: map['majorId'] as String,
      name: map['name'] as String,
      professorName: map['professorName'] as String,
      year: map['year'] as int,
      semester: map['semester'] as int,
      isPassed: map['isPassed'] as bool,
      canEnroll: map['canEnroll'] as bool,
      midTermGrade: map['midTermGrade'] as double?,
      finalGrade: map['finalGrade'] as double?,
      isMultipleChoice: map['isMultipleChoice'] as bool,
      doesHaveALab: map['doesHaveALab'] as bool,
      imageUrl: map['imageUrl'] as String? ?? "",
      materials: (map['materials'] as List<dynamic>?)
              ?.map((e) => MaterialsModel.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
