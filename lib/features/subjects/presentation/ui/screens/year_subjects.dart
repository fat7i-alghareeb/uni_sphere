//!----------------------------  Imports  -------------------------------------!//
import 'package:beamer/beamer.dart';
import 'package:test/features/subjects/domain/entities/subjects_entity.dart';
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
    required this.subjects,
    required this.year,
  });

  final List<SubjectEntity> subjects;
  final int year;
  static const String pagePath = 'year_subjects';

  static BeamerBuilder pageBuilder = (context, state, data) {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    final yearSubjectsData = data as YearSubjectsData;
    return BeamPage(
      key: ValueKey('year_subjects:$id'),
      child: YearSubjects(
        subjects: yearSubjectsData.subjects,
        year: yearSubjectsData.year,
      ),
      type: BeamPageType.fadeTransition,
    );
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScaffoldBody(
        title: YearHelper.getYearSubjectsName(year, context),
        child: SubjectsScreenBody(
          subjects: subjects,
        ),
      ),
    );
  }
}
