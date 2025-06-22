class HomeModel {
  final List<Announcement>? announcements;
  final DateTime? daysToTheFinal;
  final Statistics? statistics;

  HomeModel({
    required this.announcements,
    required this.daysToTheFinal,
    required this.statistics,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      announcements: (json['announcements'] as List<dynamic>)
          .map((e) => Announcement.fromJson(e))
          .toList(),
      daysToTheFinal: json['daysToTheFinal'] != null
          ? DateTime.parse(json['daysToTheFinal'])
          : null,
      statistics: json['statistics'] != null
          ? Statistics.fromJson(json['statistics'])
          : null,
    );
  }
}

class Announcement {
  final String? announcementId;
  final String? image;
  final String? description;

  Announcement({
    this.announcementId,
    this.image,
    this.description,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      announcementId: json['announcementId'] as String,
      image: json['image'] as String,
      description: json['description'] as String,
    );
  }
}

class Statistics {
  final double? average;
  final double? numberOfAttendanceHours;
  final int? numberOfAttendanceLectures;

  Statistics({
    this.average,
    this.numberOfAttendanceHours,
    this.numberOfAttendanceLectures,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) {
    return Statistics(
      average:
          json['average'] != null ? (json['average'] as num).toDouble() : null,
      numberOfAttendanceHours: json['numberOfAttendanceHours'] != null
          ? json['numberOfAttendanceHours'] as double
          : null,
      numberOfAttendanceLectures: json['numberOfAttendanceLectures'] != null
          ? json['numberOfAttendanceLectures'] as int
          : null,
    );
  }
}
