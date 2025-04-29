import '../../../../../shared/imports/imports.dart';
import 'ads_widget.dart';
import 'lecture_remaining_time_widget.dart';
import 'materials_widget.dart';
import 'statistics_widget.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          35.verticalSpace,
          const AdsWidget(),
          28.verticalSpace,
          const StatisticsWidget(),
          28.verticalSpace,
          const MaterialsWidget(),
          28.verticalSpace,
          const LectureRemainingTimeWidget(),
        ],
      ),
    );
  }
}
