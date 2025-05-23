import 'ads_entity.dart';
import 'days_to_the_final.dart';
import 'statistics_entity.dart';

class HomeEntity {
  final List<AdsEntity> ads;
  final StatisticsEntity statistics;
  // final List<MaterialEntity> materials;
  final DaysToTheFinals daysToTheFinals;
  HomeEntity({
    required this.ads,
    required this.statistics,
    // required this.materials,
    required this.daysToTheFinals,
  });
}
