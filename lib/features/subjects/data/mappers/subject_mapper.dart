import 'package:test/features/subjects/data/models/subjects_model.dart'
    show Subject, SubjectById;

import '../../domain/entities/subject_details_entity.dart'
    show SubjectDetailsEntity;
import '../../domain/entities/subject_entity.dart' show SubjectEntity;

extension SubjectMapper on Subject {
  SubjectEntity toEntity() {
    return SubjectEntity(
      id: id,
      title: name,
      professorName: professorName,
      year: year,
      semester: semester,
      isPassed: isPassed,
      canEnroll: canEnroll,
      midTermGrade: midTermGrade,
      finalGrade: finalGrade,
      isMultipleChoice: isMultipleChoice,
      doesHaveALab: doesHaveALab,
      imageUrl: imageUrl,
    );
  }
}

extension SubjectByIdMapper on SubjectById {
  SubjectDetailsEntity toEntity() {
    return SubjectDetailsEntity(
      id: id,
      title: name,
      professorName: professorName,
      professorIntro: professorName,
      subjectDescription: name,
      semester: semester.toString(),
      isPassed: isPassed,
      canEnroll: canEnroll,
      midTermGrade: midTermGrade,
      finalGrade: finalGrade,
      doesHaveALab: doesHaveALab,
      isMultipleChoice: isMultipleChoice,
      materials: [],
      imageUrl: imageUrl,
    );
  }
}
