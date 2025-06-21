class SimpleUser {
  final String fullName;
  final int year;
  final String studentNumber;
  final String majorName;
  final String majorId;
  final String studentId;

  SimpleUser({
    required this.fullName,
    required this.year,
    required this.studentNumber,
    required this.majorName,
    required this.majorId,
    required this.studentId,
  });

  factory SimpleUser.fromJson(Map<String, dynamic> json) {
    return SimpleUser(
      fullName: json['fullName'],
      year: json['year'],
      studentNumber: json['studentNumber'],
      majorName: json['majorName'],
      majorId: json['majorId'],
      studentId: json['studentId'],
    );
  }
}
