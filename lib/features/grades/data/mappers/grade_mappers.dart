import 'package:test/features/grades/data/models/grades_model.dart';
import 'package:test/features/grades/domain/entities/grade_entity.dart' show GradeEntity;

import '../../domain/entities/grades_response_entity.dart' show GradesResponseEntity;

extension GradeCollectionMapper on GradesModel {
  GradesResponseEntity toGradesResponseEntity() {
    return GradesResponseEntity(
      numberOfPassedSubjects: numberOfPassedSubjects,
      numberOfFailedSubjects: numberOfFailedSubjects,
      averageGrade: average,
      grades: grades.map((grade) => grade.toGradeEntity()).toList(),
    );
  }
}

extension GradeMapper on Grade {
  GradeEntity toGradeEntity() {
    return GradeEntity(
      subjectName: subjectName,
      subjectYear: subjectYear,
      subjectSemester: subjectSemester,
      midTermGrade: midTermGrade,
      finalTermGrade: finalGrade,
      isPassed: isPassed,
    );
  }
}