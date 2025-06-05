import '../../../../../shared/imports/imports.dart';
import 'ads_widget.dart';
import 'days_to_the_finals_widget.dart';
import 'materials_widget.dart';
import 'statistics_widget.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        key: const ValueKey('homeBody'),
        children: [
          25.verticalSpace,
          const AdsWidget(),
          28.verticalSpace,
          const DaysToTheFinalsWidget(),
          28.verticalSpace,
          const StatisticsWidget(
            key: ValueKey('statisticsWidget'),
          ),
          28.verticalSpace,
          const MaterialsWidget(),
          100.verticalSpace,
        ],
      ),
    );
  }
}
