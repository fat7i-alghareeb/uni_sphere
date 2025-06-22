class AnnouncementsModel {
  final List<Announcement> announcements;

  AnnouncementsModel({
    required this.announcements,
  });

  factory AnnouncementsModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementsModel(
      announcements: (json['announcements'] as List<dynamic>)
          .map((e) => Announcement.fromJson(e))
          .toList(),
    );
  }
}

class Announcement {
  final String announcementId;
  final String title;
  final String description;
  final List<String>? images;
  final DateTime createdAt;

  Announcement({
    required this.announcementId,
    required this.title,
    required this.description,
    this.images,
    required this.createdAt,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      announcementId: json['announcementId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      images: json['images'] != null
          ? List<String>.from(json['images'] as List<dynamic>)
          : null,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
