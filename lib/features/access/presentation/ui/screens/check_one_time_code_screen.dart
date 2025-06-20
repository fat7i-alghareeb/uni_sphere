import 'package:beamer/beamer.dart' show BeamPage, BeamPageType;
import 'package:test/router/router_config.dart' show BeamerBuilder;
import 'package:test/shared/imports/imports.dart';

import '../../../../../shared/widgets/custom_scaffold_body.dart'
    show CustomScaffoldBody;

class CheckOneTimeCodeScreen extends StatelessWidget {
  const CheckOneTimeCodeScreen({super.key});
  static const String pagePath = 'check_one_time_code';
  static BeamerBuilder pageBuilder = (context, state, data) {
    return BeamPage(
      key: ValueKey("check_one_time_code"),
      child: const CheckOneTimeCodeScreen(),
      type: BeamPageType.fadeTransition,
    );
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const CustomScaffoldBody(
        child: Text('Check One Time Code'),
      ),
    );
  }
}
