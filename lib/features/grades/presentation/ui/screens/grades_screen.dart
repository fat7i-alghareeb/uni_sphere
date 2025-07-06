//!----------------------------  Imports  -------------------------------------!//
import 'package:beamer/beamer.dart';

import '../../../../../core/injection/injection.dart';
import '../../../../../core/result_builder/result.dart';
import '../../../../../router/router_config.dart';
import '../../../../../shared/imports/imports.dart';
import '../../state/bloc/grade_bloc.dart';
import '../widgets/grades_list_widget.dart';
import '../widgets/grades_statistics_widget.dart';

//!---------------------------- The Widget -------------------------------------!//
class GradesScreen extends StatefulWidget {
  const GradesScreen({super.key});

  static const String pagePath = 'grades_screen';

  static BeamerBuilder pageBuilder = (context, state, data) {
    return BeamPage(
      key: ValueKey('grades_screen'),
      child: const GradesScreen(),
      type: BeamPageType.fadeTransition,
    );
  };

  @override
  State<GradesScreen> createState() => _GradesScreenState();
}

class _GradesScreenState extends State<GradesScreen>
    with SingleTickerProviderStateMixin {
  late final GradeBloc _gradeBloc;
  late final AnimationController _headerController;
  late final Animation<double> _headerAnimation;

  @override
  void initState() {
    super.initState();
    _gradeBloc = getIt<GradeBloc>();

    // Trigger the BLoC's initial state by dispatching the GetGradesEvent
    _gradeBloc.add(GetGradesEvent());

    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _headerAnimation = CurvedAnimation(
      parent: _headerController,
      curve: Curves.easeOut,
    );
    _headerController.forward();
  }

  @override
  void dispose() {
    _headerController.dispose();
    super.dispose();
  }

  /// Handles retry when an error occurs
  void _handleRetry() {
    _gradeBloc.add(GetGradesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: _gradeBloc,
        child: Column(
          children: [
            40.verticalSpace,
            BlocBuilder<GradeBloc, GradeState>(
              builder: (context, state) {
                if (state.result.isLoaded()) {
                  final gradesResponse = state.result.getDataWhenSuccess();
                  if (gradesResponse != null) {
                    return Column(
                      children: [
                        GradesStatisticsWidget(
                          gradesResponse: gradesResponse,
                          animation: _headerAnimation,
                        ),
                        16.verticalSpace,
                        _buildDivider(context),
                      ],
                    );
                  }
                }
                return const SizedBox.shrink();
              },
            ),
            Expanded(
              child: BlocBuilder<GradeBloc, GradeState>(
                builder: (context, state) {
                  return GradesListWidget(
                    state: state.result,
                    onRefresh: () async {
                      _gradeBloc.add(GetGradesEvent());
                    },
                    onError:
                        _handleRetry, // Pass the retry callback to use custom FailedWidget
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
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
  }
}
