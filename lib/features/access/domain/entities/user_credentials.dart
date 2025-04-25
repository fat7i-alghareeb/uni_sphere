class UserCredentialsEntity {
  final String idNumber;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String majorName;
  final String yearOfStudy;
  final String enrollmentStatus;
  final String profilePicture;
  UserCredentialsEntity({
    required this.idNumber,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.majorName,
    required this.yearOfStudy,
    required this.enrollmentStatus,
    required this.profilePicture,
  });
}
