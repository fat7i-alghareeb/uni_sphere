import 'package:test/core/auth_data_source/local/auth_local.dart';
import 'package:test/core/injection/injection.dart';
import 'package:test/features/access/presentation/ui/screens/login_screen.dart'
    show LoginScreen;
import 'package:test/router/router_config.dart' show BeamerBuilder;
import 'package:test/shared/imports/imports.dart';
import 'package:test/shared/utils/helper/colored_print.dart';
import '../../../../../common/constant/app_strings.dart' show AppStrings;
import 'package:beamer/beamer.dart';

import '../../../../../shared/widgets/custom_scaffold_body.dart'
    show CustomScaffoldBody;
import '../../../../../shared/widgets/auth_button.dart' show AuthButton;
import 'check_one_time_code_screen.dart' show CheckOneTimeCodeScreen;

class ChooseAccessMethodScreen extends StatelessWidget {
  const ChooseAccessMethodScreen({super.key});
  static const String pagePath = 'choose_access_method';
  static BeamerBuilder pageBuilder = (context, state, data) {
    return const BeamPage(
      key: ValueKey("choose_access_method"),
      child: ChooseAccessMethodScreen(),
      type: BeamPageType.fadeTransition,
    );
  };
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomScaffoldBody(
        child: ChooseMethodBody(),
      ),
    );
  }
}

class ChooseMethodBody extends StatefulWidget {
  const ChooseMethodBody({super.key});

  @override
  State<ChooseMethodBody> createState() => _ChooseMethodBodyState();
}

class _ChooseMethodBodyState extends State<ChooseMethodBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.0, 0.5, curve: Curves.easeIn)),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
            CurvedAnimation(
                parent: _controller,
                curve: const Interval(0.5, 1.0, curve: Curves.easeOutCubic)));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(
        horizontal: AppConstants.horizontalScreensPadding,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FadeTransition(
              opacity: _fadeAnimation,
              child: const FlutterLogo(size: 120),
            ),
            30.verticalSpace,
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Text(
                  AppStrings.welcomeToUniSphere,
                  style: context.textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            80.verticalSpace,
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: ChooseMethodButton(
                  title: AppStrings.login,
                  onTap: () {
                    context.beamToNamed(LoginScreen.pagePath);
                  },
                ),
              ),
            ),
            20.verticalSpace,
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: ChooseMethodButton(
                  title: AppStrings.register,
                  onTap: () {
                    context.beamToNamed(CheckOneTimeCodeScreen.pagePath);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChooseMethodButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const ChooseMethodButton(
      {required this.title, required this.onTap, super.key});
  @override
  Widget build(BuildContext context) {
    return AuthButton.primary(
      title: title,
      onPressed: onTap,
      context: context,
      height: 50.h,
      borderRadius: 16,
    );
  }
}
