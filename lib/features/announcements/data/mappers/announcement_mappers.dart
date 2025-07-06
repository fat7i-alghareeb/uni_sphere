import '../../../../core/constants/dummy_data.dart';
import '../models/announcements_model.dart';
import '../../../../shared/extensions/date_time_extension.dart';

import '../../domain/entities/news_entity.dart';

extension AnnouncementMapper on Announcement {
  NewsEntity toEntity() {
    return NewsEntity(
      id: announcementId,
      title: title,
      description: description,
      image: dummyImages,
      createdAt: createdAt.toIso8601String().fullDate(),
    );
  }
}
