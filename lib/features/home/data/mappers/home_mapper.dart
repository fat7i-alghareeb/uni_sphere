import '../models/home_model.dart';

import '../../domain/entities/ads_entity.dart' show AdsEntity;
import '../../domain/entities/home_entity.dart';
import '../../domain/entities/statistics_entity.dart';
import '../../domain/entities/days_to_the_final.dart';

extension HomeMapper on HomeModel {
  HomeEntity toEntity() {
    return HomeEntity(
      ads: announcements?.map((e) => e.toEntity()).toList() ?? [],
      statistics: statistics != null
          ? statistics!.toEntity()
          : StatisticsEntity(
              numberOfAttendanceHours: 0,
              numberOfAttendanceLectures: 0,
              numberOfDaysToTheFinals: 0,
              numberOfDownloadedMaterials: 0,
            ),
      daysToTheFinals: daysToTheFinal != null
          ? DaysToTheFinals(remainingTime: daysToTheFinal!.toIso8601String())
          : DaysToTheFinals(remainingTime: '0'),
      // materials: materials,
      // announcements: announcements,
    );
  }
}

extension AdsMapper on Announcement {
  AdsEntity toEntity() {
    return AdsEntity(
      imageUrl: image ?? '',
      description: description ?? '',
    );
  }
}

extension StatisticsMapper on Statistics {
  StatisticsEntity toEntity() {
    return StatisticsEntity(
      numberOfAttendanceHours: numberOfAttendanceHours ?? 0.0,
      numberOfAttendanceLectures: numberOfAttendanceLectures ?? 0,
      numberOfDaysToTheFinals: 0,
      numberOfDownloadedMaterials: 0,
    );
  }
}
