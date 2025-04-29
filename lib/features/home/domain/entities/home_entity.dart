import '../../../subjects/domain/entities/materials_entity.dart';
import 'ads_entity.dart';
import 'lecture_remaining_time.dart';
import 'statistics_entity.dart';

class HomeEntity {
  final List<AdsEntity> ads;
  final StatisticsEntity statistics;
  final List<MaterialEntity> materials;
  final LectureRemainingTime lectureRemainingTime;
  HomeEntity({
    required this.ads,
    required this.statistics,
    required this.materials,
    required this.lectureRemainingTime,
  });
}
