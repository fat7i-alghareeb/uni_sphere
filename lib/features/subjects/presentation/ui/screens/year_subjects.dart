//!----------------------------  Imports  -------------------------------------!//
import 'package:beamer/beamer.dart';
import 'package:test/core/injection/injection.dart' show getIt;
import 'package:test/core/result_builder/result.dart';
import 'package:test/features/subjects/domain/entities/subject_entity.dart';
import 'package:test/features/subjects/presentation/state/subjects_bloc/subjects_bloc.dart'
    show SubjectsBloc, SubjectsState;

import '../../../../../router/router_config.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../../../shared/utils/helper/year_helper.dart';
import '../../../../../shared/widgets/custom_scaffold_body.dart';
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
class YearSubjects extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SubjectsBloc, SubjectsState>(
        builder: (context, state) {

          return CustomScaffoldBody(
            title: YearHelper.getYearSubjectsName(state.selectedYear, context),
            child: SubjectsScreenBody(
              subjects: state.yearResult.getDataWhenSuccess() ?? [],
              fullInfo: false,
            ),
          );
        },
      ),
    );
  }
}
