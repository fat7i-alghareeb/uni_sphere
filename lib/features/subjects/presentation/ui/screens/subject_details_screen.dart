//!----------------------------  Imports  -------------------------------------!//
import 'package:beamer/beamer.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../router/router_config.dart';
import '../../../../../shared/imports/imports.dart';
import '../../state/subject_details_bloc/subject_details_bloc.dart';

//!---------------------------- The Widget -------------------------------------!//
class SubjectDetailsScreen extends StatelessWidget {
  const SubjectDetailsScreen({super.key});

  static const String pagePath = 'subject_details';

  static BeamerBuilder pageBuilder = (context, state, data) {
    String id = DateTime.now().millisecondsSinceEpoch.toString();

    return BeamPage(
      key: ValueKey(':$id'),
      child: const SubjectDetailsScreen(),
      type: BeamPageType.fadeTransition,
    );
  };

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<SubjectDetailsBloc>(),
      child: const SizedBox(),
    );
  }
}
