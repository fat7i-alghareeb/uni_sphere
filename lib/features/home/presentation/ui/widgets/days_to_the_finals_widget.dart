import '../../../../../core/result_builder/result_builder.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../domain/entities/home_entity.dart';
import '../../state/bloc/home_bloc.dart';
import 'days_to_the_finals_content.dart';

class DaysToTheFinalsWidget extends StatelessWidget {
  const DaysToTheFinalsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(
        horizontal: AppConstants.horizontalScreensPadding,
      ),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return ResultBuilder<HomeEntity>(
            loading: () => const DaysToTheFinalsLoadingBody(),
            success: (data) {
              return DaysToTheFinalsBody(
                targetDate: DateTime.now().add(const Duration(days: 10)),
                // targetDate: DateTime.parse(data.daysToTheFinals.remainingTime),
              );
            },
            result: state.result,
          );
        },
      ),
    );
  }
}
