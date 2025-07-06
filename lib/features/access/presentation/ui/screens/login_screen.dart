import 'package:beamer/beamer.dart' show BeamPage, BeamPageType;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocProvider, MultiBlocProvider;
import 'package:test/core/injection/injection.dart' show getIt;
import 'package:test/features/access/presentation/state/bloc/auth_bloc.dart'
    show AuthBloc;
import 'package:test/features/access/presentation/ui/widgets/login_body.dart';
import 'package:test/router/router_config.dart';
import 'package:test/shared/imports/imports.dart';
import 'package:test/shared/states/bloc/info_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const String pagePath = 'login';
  static BeamerBuilder pageBuilder = (context, state, data) {
    return BeamPage(
      key: ValueKey("login"),
      child: const LoginScreen(),
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
              BlocProvider.value(value: getIt<AuthBloc>()),
              BlocProvider.value(value: getIt<InfoBloc>()),
            ],
            child: LoginBody(),
          ),
        ),
      ),
    );
  }
}
