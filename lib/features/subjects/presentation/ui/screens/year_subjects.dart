//!----------------------------  Imports  -------------------------------------!//
import 'package:beamer/beamer.dart';
import 'package:test/features/subjects/domain/entities/subjects_entity.dart';
import '../../../../../router/router_config.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../../../shared/widgets/custom_scaffold_body.dart';

//!---------------------------- The Widget -------------------------------------!//
class YearSubjects extends StatelessWidget {
  const YearSubjects({super.key, required this.subjects});
  final List<SubjectEntity> subjects;
  static const String pagePath = 'year_subjects';

  static BeamerBuilder pageBuilder = (context, state, data) {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    final subjects = data as List<SubjectEntity>?;
    return BeamPage(
      key: ValueKey('year_subjects:$id'),
      child: YearSubjects(subjects: subjects ?? []),
      type: BeamPageType.fadeTransition,
    );
  };

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScaffoldBody(
        child: SizedBox(),
      ),
    );
  }
}
