import 'package:test/features/subjects/data/models/subjects_model.dart'
    show Subject, SubjectById;
import 'package:test/features/subjects/data/models/materials_model.dart'
    show MaterialsModel;

import '../../domain/entities/subject_details_entity.dart'
    show SubjectDetailsEntity;
import '../../domain/entities/subject_entity.dart' show SubjectEntity;
import '../../domain/entities/materials_entity.dart'
    show MaterialEntity, MaterialUrlType;

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

extension MaterialsModelMapper on MaterialsModel {
  MaterialEntity toEntity() {
    return MaterialEntity(
      url: url,
      type: type,
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
      materials: materials.map((material) => material.toEntity()).toList(),
      imageUrl: imageUrl,
    );
  }
}
