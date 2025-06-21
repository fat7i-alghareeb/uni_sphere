import 'package:beamer/beamer.dart' show BeamPage, BeamPageType;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show MultiBlocProvider;
import 'package:test/core/injection/injection.dart' show getIt;
import 'package:test/features/access/presentation/state/bloc/auth_bloc.dart'
    show AuthBloc;
import 'package:test/features/access/presentation/ui/widgets/check_one_time_code_body.dart';
import 'package:test/router/router_config.dart' show BeamerBuilder;
import 'package:test/shared/imports/imports.dart';
import 'package:test/shared/states/bloc/info_bloc.dart'
    show InfoBloc;


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
              BlocProvider.value(
                value: getIt<InfoBloc>(),
              ),
            ],
            child: CheckOneTimeCodeBody(),
          ),
        ),
      ),
    );
  }
}
