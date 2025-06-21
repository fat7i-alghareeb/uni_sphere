//!----------------------------  Imports  -------------------------------------!//
import 'package:beamer/beamer.dart';
import 'package:test/core/injection/injection.dart' show getIt;
import 'package:test/core/result_builder/result.dart';
import 'package:test/features/subjects/domain/entities/subject_entity.dart';
import 'package:test/features/subjects/presentation/state/subjects_bloc/subjects_bloc.dart';

import '../../../../../common/constant/app_strings.dart';
import '../../../../../router/router_config.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../../../shared/utils/helper/year_helper.dart';
import '../../../../../shared/widgets/custom_scaffold_body.dart';
import '../../../../../shared/widgets/failed_widget.dart';
import '../widgets/subject_screen_body.dart';

/// Data class to hold the navigation data for YearSubjects screen
class YearSubjectsData {
  final List<SubjectEntity> subjects;
  final int year;

  const YearSubjectsData({
    required this.subjects,
    required this.year,
  });
}

//!---------------------------- The Widget -------------------------------------!//
class YearSubjects extends StatefulWidget {
  const YearSubjects({
    super.key,
  });

  static const String pagePath = 'year_subjects';

  static BeamerBuilder pageBuilder = (context, state, data) {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    return BeamPage(
      key: ValueKey('year_subjects:$id'),
      child: BlocProvider.value(
        value: getIt<SubjectsBloc>(),
        child: YearSubjects(),
      ),
      type: BeamPageType.fadeTransition,
    );
  };

  @override
  State<YearSubjects> createState() => _YearSubjectsState();
}

class _YearSubjectsState extends State<YearSubjects> {
  late final SubjectsBloc _subjectsBloc;

  @override
  void initState() {
    super.initState();
    try {
      _subjectsBloc = getIt<SubjectsBloc>();
    } catch (e) {
      debugPrint('Error initializing YearSubjects: $e');
    }
  }

  /// Handles retry when an error occurs
  void _handleRetry() {
    try {
      if (_subjectsBloc.state.selectedYear > 0) {
        _subjectsBloc
            .add(GetYearSubjectsEvent(_subjectsBloc.state.selectedYear));
      }
    } catch (e) {
      debugPrint('Error in retry: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        body: BlocBuilder<SubjectsBloc, SubjectsState>(
          builder: (context, state) {
            // Handle error state manually
            if (state.yearResult.isError()) {
              return CustomScaffoldBody(
                title:
                    YearHelper.getYearSubjectsName(state.selectedYear, context),
                child: FailedWidget(
                  error: state.yearResult.getError(),
                  onPressed: _handleRetry,
                  retryText: AppStrings.tryAgain,
                ),
              );
            }

            // Handle loading state
            if (state.yearResult.isLoading()) {
              return CustomScaffoldBody(
                title:
                    YearHelper.getYearSubjectsName(state.selectedYear, context),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            // Handle success state
            return CustomScaffoldBody(
              title:
                  YearHelper.getYearSubjectsName(state.selectedYear, context),
              child: SubjectsScreenBody(
                subjects: state.yearResult.getDataWhenSuccess() ?? [],
                fullInfo: false,
                onRefresh: () async {
                  try {
                    if (state.selectedYear > 0) {
                      _subjectsBloc
                          .add(GetYearSubjectsEvent(state.selectedYear));
                    }
                  } catch (e) {
                    debugPrint('Error in refresh: $e');
                  }
                },
              ),
            );
          },
        ),
      );
    } catch (e) {
      debugPrint('Error building YearSubjects: $e');
      return Scaffold(
        body: Center(
          child: Text(AppStrings.somethingWentWrong),
        ),
      );
    }
  }
}
