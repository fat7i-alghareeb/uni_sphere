class User {
  final String id;
  final String firstName;
  final String lastName;
  final String fatherName;
  final String enrollmentStatusName;
  final String majorName;
  final String studentNumber;
  final int year;
  final String accessToken;
  final String refreshToken;
  final String deviceToken;

  User({
    required this.firstName,
    required this.accessToken,
    required this.refreshToken,
    required this.id,
    required this.deviceToken,
    required this.lastName,
    required this.fatherName,
    required this.enrollmentStatusName,
    required this.majorName,
    required this.studentNumber,
    required this.year,
  });

  @override
  String toString() {
    return 'User{id: $id, name: $firstName, accessToken: $accessToken, refreshToken: $refreshToken}';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': firstName,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      fatherName: map['fatherName'] as String,
      enrollmentStatusName: map['enrollmentStatusName'] as String,
      majorName: map['majorName'] as String,
      studentNumber: map['studentNumber'] as String,
      year: map['year'] as int,
      accessToken: map['accessToken'] as String,
      refreshToken: map['refreshToken'] as String,
      deviceToken: map['deviceToken'] as String,
    );
  }
}
