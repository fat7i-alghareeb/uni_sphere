import '../../../../../shared/imports/imports.dart';
import '../../../domain/entities/statistics_entity.dart';
import 'statistics_card.dart';

/// A widget that displays statistics cards in a grid layout.
/// Each card shows different statistics like attendance hours, lectures, etc.
class StatisticsWidget extends StatelessWidget {
  const StatisticsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(
        horizontal: AppConstants.horizontalScreensPadding,
      ),
      child: SizedBox(
        height: 320.h,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  const Expanded(
                    child: StatisticsCard(
                      type: StatisticsCardType.attendanceHours,
                    ),
                  ),
                  26.horizontalSpace,
                  const Expanded(
                    child: StatisticsCard(
                      type: StatisticsCardType.attendanceLectures,
                    ),
                  ),
                ],
              ),
            ),
            15.verticalSpace,
            Expanded(
              child: Row(
                children: [
                  const Expanded(
                    child: StatisticsCard(
                      type: StatisticsCardType.daysToTheFinals,
                    ),
                  ),
                  26.horizontalSpace,
                  const Expanded(
                    child: StatisticsCard(
                      type: StatisticsCardType.downloadedMaterials,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
