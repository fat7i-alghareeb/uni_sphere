class User {
  final String studentId;
  final Map<String, String> firstName;
  final Map<String, String> lastName;
  final Map<String, String> fatherName;
  final Map<String, String> enrollmentStatusName;
  final Map<String, String> majorName;
  final String studentNumber;
  final int year;
  final int numberOfMajorYears;
  final String studentImageUrl;
  final String majorId;
  final String role;

  User({
    required this.firstName,
    required this.studentId,
    required this.lastName,
    required this.fatherName,
    required this.enrollmentStatusName,
    required this.majorName,
    required this.studentNumber,
    required this.year,
    required this.numberOfMajorYears,
    required this.studentImageUrl,
    required this.majorId,
    required this.role,
  });

  // Helper methods to get localized strings
  String getFirstName(String language) =>
      firstName[language] ?? firstName['en'] ?? '';
  String getLastName(String language) =>
      lastName[language] ?? lastName['en'] ?? '';
  String getFatherName(String language) =>
      fatherName[language] ?? fatherName['en'] ?? '';
  String getEnrollmentStatusName(String language) =>
      enrollmentStatusName[language] ?? enrollmentStatusName['en'] ?? '';
  String getMajorName(String language) =>
      majorName[language] ?? majorName['en'] ?? '';

  // For backward compatibility, default to English
  String get firstNameEn => getFirstName('en');
  String get lastNameEn => getLastName('en');
  String get fatherNameEn => getFatherName('en');
  String get enrollmentStatusNameEn => getEnrollmentStatusName('en');
  String get majorNameEn => getMajorName('en');

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'studentId': studentId,
      'firstName': firstName,
      'lastName': lastName,
      'fatherName': fatherName,
      'enrollmentStatusName': enrollmentStatusName,
      'majorName': majorName,
      'studentNumber': studentNumber,
      'year': year,
      'numberOfMajorYears': numberOfMajorYears,
      'studentImageUrl': studentImageUrl,
      'majorId': majorId,
      'role': role,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      studentId: map['studentId'] as String? ?? map['id'] as String? ?? '',
      firstName: _parseLocalizedString(map['firstName']),
      lastName: _parseLocalizedString(map['lastName']),
      fatherName: _parseLocalizedString(map['fatherName']),
      enrollmentStatusName: _parseLocalizedString(map['enrollmentStatusName']),
      majorName: _parseLocalizedString(map['majorName']),
      studentNumber: map['studentNumber'] as String? ?? '',
      year: map['year'] as int? ?? 0,
      numberOfMajorYears: map['numberOfMajorYears'] as int? ?? 0,
      studentImageUrl:
          map['studentImageUrl'] as String? ?? map['image'] as String? ?? '',
      majorId: map['majorId'] as String? ?? '',
      role: map['role'] as String? ?? '',
    );
  }

  // Helper method to parse localized strings
  static Map<String, String> _parseLocalizedString(dynamic value) {
    if (value is Map<String, dynamic>) {
      return Map<String, String>.from(value);
    } else if (value is String) {
      // For backward compatibility, if it's a plain string, wrap it in English
      return {'en': value, 'ar': value};
    }
    return {'en': '', 'ar': ''};
  }
}

class FullUser extends User {
  final String refreshToken;
  final String accessToken;

  FullUser({
    required super.firstName,
    required super.lastName,
    required super.studentId,
    required super.year,
    required super.majorName,
    required super.studentNumber,
    required super.enrollmentStatusName,
    required super.fatherName,
    required this.refreshToken,
    required this.accessToken,
    required super.numberOfMajorYears,
    required super.studentImageUrl,
    required super.majorId,
    required super.role,
  });

  factory FullUser.fromMap(Map<String, dynamic> map) {
    return FullUser(
      firstName: User._parseLocalizedString(map['firstName']),
      lastName: User._parseLocalizedString(map['lastName']),
      studentId: map['studentId'] as String? ?? '',
      year: map['year'] as int? ?? 0,
      majorName: User._parseLocalizedString(map['majorName']),
      studentNumber: map['studentNumber'] as String? ?? '',
      enrollmentStatusName:
          User._parseLocalizedString(map['enrollmentStatusName']),
      fatherName: User._parseLocalizedString(map['fatherName']),
      refreshToken: map['refreshToken'] as String? ?? '',
      accessToken: map['accessToken'] as String? ?? '',
      numberOfMajorYears: map['numberOfMajorYears'] as int? ?? 0,
      studentImageUrl:
          map['studentImageUrl'] as String? ?? map['image'] as String? ?? '',
      majorId: map['majorId'] as String? ?? '',
      role: map['role'] as String? ?? '',
    );
  }
}
