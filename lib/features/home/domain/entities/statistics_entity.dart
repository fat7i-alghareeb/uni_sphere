class StatisticsEntity {
  final double numberOfAttendanceHours;
  final int numberOfAttendanceLectures;
  final int numberOfDaysToTheFinals;
  final int numberOfDownloadedMaterials;
  StatisticsEntity({
    required this.numberOfAttendanceHours,
    required this.numberOfAttendanceLectures,
    required this.numberOfDaysToTheFinals,
    required this.numberOfDownloadedMaterials,
  });
}

enum StatisticsCardType {
  attendanceHours,
  attendanceLectures,
  daysToTheFinals,
  downloadedMaterials,
}
