import 'package:test/features/announcements/data/models/announcements_model.dart';

import '../../domain/entities/news_entity.dart';

extension AnnouncementMapper on Announcement {
  NewsEntity toEntity() {
    return NewsEntity(
      id: announcementId,
      title: title,
      description: description,
      image: images,
      createdAt: createdAt.toIso8601String(),
    );
  }
}
