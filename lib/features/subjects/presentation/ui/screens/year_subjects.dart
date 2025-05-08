//!----------------------------  Imports  -------------------------------------!//
import 'package:beamer/beamer.dart';
import '../../../../../router/router_config.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../../../shared/widgets/custom_scaffold_body.dart';

//!---------------------------- The Widget -------------------------------------!//
class YearSubjects extends StatelessWidget {
  const YearSubjects({super.key});

  static const String pagePath = 'year_subjects';

  static BeamerBuilder pageBuilder = (context, state, data) {
    String id = DateTime.now().millisecondsSinceEpoch.toString();

    return BeamPage(
      key: ValueKey('year_subjects:$id'),
      child: const YearSubjects(),
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