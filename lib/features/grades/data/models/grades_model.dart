class GradesModel {
  final int numberOfPassedSubjects;
  final int numberOfFailedSubjects;
  final double average;
  final List<Grade> grades;

  GradesModel({
    required this.numberOfPassedSubjects,
    required this.numberOfFailedSubjects,
    required this.average,
    required this.grades,
  });

  factory GradesModel.fromJson(Map<String, dynamic> json) {
    return GradesModel(
      numberOfPassedSubjects: json['numberOfPassedSubjects'],
      numberOfFailedSubjects: json['numberOfFailedSubjects'],
      average: (json['average'] as num).toDouble(),
      grades: (json['grades'] as List<dynamic>)
          .map((grade) => Grade.fromJson(grade))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'numberOfPassedSubjects': numberOfPassedSubjects,
      'numberOfFailedSubjects': numberOfFailedSubjects,
      'average': average,
      'grades': grades.map((g) => g.toJson()).toList(),
    };
  }
}

class Grade {
  final int subjectYear;
  final int subjectSemester;
  final double midTermGrade;
  final double finalGrade;
  final String subjectName;
  final bool isPassed;

  Grade({
    required this.subjectYear,
    required this.subjectSemester,
    required this.midTermGrade,
    required this.finalGrade,
    required this.subjectName,
    required this.isPassed,
  });

  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      subjectYear: json['subjectYear'],
      subjectSemester: json['subjectSemester'],
      midTermGrade: (json['midTermGrade'] as num).toDouble(),
      finalGrade: (json['finalGrade'] as num).toDouble(),
      subjectName: json['subjectName'],
      isPassed: json['isPassed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subjectYear': subjectYear,
      'subjectSemester': subjectSemester,
      'midTermGrade': midTermGrade,
      'finalGrade': finalGrade,
      'subjectName': subjectName,
      'isPassed': isPassed,
    };
  }
}
