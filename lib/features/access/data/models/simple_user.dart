class SimpleUser {
  final Map<String, String> fullName;
  final int year;
  final String studentNumber;
  final Map<String, String> majorName;
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

  // Helper methods to get localized strings
  String getFullName(String language) =>
      fullName[language] ?? fullName['en'] ?? '';
  String getMajorName(String language) =>
      majorName[language] ?? majorName['en'] ?? '';

  // For backward compatibility, default to English
  String get fullNameEn => getFullName('en');
  String get majorNameEn => getMajorName('en');

  factory SimpleUser.fromJson(Map<String, dynamic> json) {
    return SimpleUser(
      fullName: _parseLocalizedString(json['fullName']),
      year: json['year'] as int? ?? 0,
      studentNumber: json['studentNumber'] as String? ?? '',
      majorName: _parseLocalizedString(json['majorName']),
      majorId: json['majorId'] as String? ?? '',
      studentId: json['studentId'] as String? ?? '',
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
