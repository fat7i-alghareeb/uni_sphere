import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/core/injection/injection.dart';
import 'package:test/features/access/presentation/state/bloc/auth_bloc.dart';
import 'package:test/features/access/presentation/ui/widgets/register_body.dart';
import 'package:test/router/router_config.dart';
import 'package:test/shared/imports/imports.dart';

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
    return KeyedSubtree(
      key: ValueKey(context.locale),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getIt<AuthBloc>(),
              ),
            ],
            child: RegisterBody(),
          ),
        ),
      ),
    );
  }
}
