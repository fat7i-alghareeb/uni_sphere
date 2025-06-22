import 'package:beamer/beamer.dart';
import '../../../../../shared/utils/helper/colored_print.dart';
import '../../../../../common/constant/app_strings.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../core/result_builder/result.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../../../shared/widgets/failed_widget.dart';
import '../../../../home/presentation/ui/widgets/decorated_container.dart';
import '../../state/subjects_bloc/subjects_bloc.dart';
import '../widgets/subjects_builder_widget.dart';
import 'choose_years_screen.dart';

/// A screen that displays a list of subjects.
class SubjectsScreen extends StatefulWidget {
  const SubjectsScreen({super.key});

  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen>
    with AutomaticKeepAliveClientMixin {
  late final SubjectsBloc _subjectsBloc;

  @override
  void initState() {
    super.initState();
    try {
      _subjectsBloc = getIt<SubjectsBloc>();
      _subjectsBloc.add(GetSubjectsEvent());
    } catch (e) {
      debugPrint('Error initializing SubjectsScreen: $e');
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    try {
      printR("disposing");
    } catch (e) {
      debugPrint('Error in dispose: $e');
    }
    super.dispose();
  }

  /// Handles retry when an error occurs
  void _handleRetry() {
    try {
      _subjectsBloc.add(GetSubjectsEvent());
    } catch (e) {
      debugPrint('Error in retry: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider.value(
      value: _subjectsBloc,
      child: Column(
        children: [
          _buildHeader(context),
          _buildDivider(context),
          Expanded(
            child: BlocBuilder<SubjectsBloc, SubjectsState>(
              builder: (context, state) {
                // Handle error state manually
                if (state.result.isError()) {
                  return Center(
                    child: FailedWidget(
                      error: state.result.getError(),
                      onPressed: _handleRetry,
                      retryText: AppStrings.tryAgain,
                    ),
                  );
                }

                return SubjectsBuilderWidget(
                  state: state.result,
                  onRefresh: () async {
                    try {
                      _subjectsBloc.add(GetSubjectsEvent());
                    } catch (e) {
                      debugPrint('Error in refresh: $e');
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    try {
      return Padding(
        padding: REdgeInsets.symmetric(
          horizontal: AppConstants.horizontalScreensPadding,
          vertical: 15,
        ),
        child: DecoratedContainer(
          onTap: () => context.beamToNamed(ChooseYearsScreen.pagePath),
          circleSize: 120,
          child: Padding(
            padding: REdgeInsets.all(12.0),
            child: Text(
              AppStrings.yourSubjects,
              style: context.textTheme.headlineLarge!
                  .withColor(context.primaryColor),
            ),
          ),
        ),
      );
    } catch (e) {
      debugPrint('Error building header: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildDivider(BuildContext context) {
    try {
      return Padding(
        padding: REdgeInsets.symmetric(
          horizontal: AppConstants.horizontalScreensPadding,
        ),
        child: Divider(
          height: 1.h,
          thickness: 1.h,
          color: context.primaryColor.withValues(alpha: 0.5),
        ),
      );
    } catch (e) {
      debugPrint('Error building divider: $e');
      return const SizedBox.shrink();
    }
  }
}
