import 'package:beamer/beamer.dart' show BeamPage, BeamPageType;
import 'package:test/router/router_config.dart';
import 'package:test/shared/imports/imports.dart';

import '../../../../../shared/widgets/custom_scaffold_body.dart' show CustomScaffoldBody;

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  static const String pagePath = 'register';
  static BeamerBuilder pageBuilder = (context, state, data) {
    return BeamPage(
      key: ValueKey("register"),
      child: const RegisterScreen(),
      type: BeamPageType.fadeTransition,
    );
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScaffoldBody(
        child: const Center(
          child: Text('Register'),
        ),
      ),
    );
  }
}
