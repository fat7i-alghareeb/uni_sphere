import '../../../../../core/result_builder/result.dart';
import '../../state/bloc/home_bloc.dart';
import '../../../../../shared/widgets/failed_widget.dart';

import '../../../../../core/injection/injection.dart' show getIt;
import '../../../../../shared/imports/imports.dart';
import 'ads_widget.dart';
import 'days_to_the_finals_widget.dart';
import 'materials_widget.dart';
import 'statistics_widget.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.result.isError()) {
          return FailedWidget(
            error: state.result.getError(),
            onPressed: () {
              getIt<HomeBloc>().add(GetHomeEvent());
            },
          );
        }
        return RefreshIndicator(
          onRefresh: () async {
            getIt<HomeBloc>().add(GetHomeEvent());
          },
          child: SingleChildScrollView(
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
          ),
        );
      },
    );
  }
}
