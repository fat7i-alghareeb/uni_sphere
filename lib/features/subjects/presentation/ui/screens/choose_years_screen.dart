//!----------------------------  Imports  -------------------------------------!//
import 'package:beamer/beamer.dart';
import 'package:test/common/constant/app_strings.dart';
import 'package:test/core/injection/injection.dart';
import 'package:test/features/subjects/presentation/state/bloc/subjects_bloc.dart';
import 'package:test/shared/widgets/custom_scaffold_body.dart';
import '../../../../../router/router_config.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../../home/presentation/ui/widgets/decorated_container.dart';

//!---------------------------- The Widget -------------------------------------!//
class ChooseYearsScreen extends StatefulWidget {
  const ChooseYearsScreen({super.key});

  static const String pagePath = 'choose_years_screen';

  static BeamerBuilder pageBuilder = (context, state, data) {
    String id = DateTime.now().millisecondsSinceEpoch.toString();

    return BeamPage(
      key: ValueKey('choose_years_screen:$id'),
      child: const ChooseYearsScreen(),
      type: BeamPageType.fadeTransition,
    );
  };

  @override
  State<ChooseYearsScreen> createState() => _ChooseYearsScreenState();
}

class _ChooseYearsScreenState extends State<ChooseYearsScreen> {
  bool l = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SubjectsBloc>(),
      child: Scaffold(
        body: CustomScaffoldBody(
          title: "Computer Engineering",
          child: ListView.builder(
            padding: REdgeInsets.only(
              left: AppConstants.horizontalScreensPadding,
              right: AppConstants.horizontalScreensPadding,
              top: 30,
              bottom: 50,
            ),
            itemBuilder: (context, index) => DecoratedContainer(
              onTap: () {
                l = !l;
                setState(() {});
              },
              padding: REdgeInsets.symmetric(vertical: 8),
              animate: l,
              circleSize: 130,
              child: Padding(
                padding: REdgeInsets.all(12.0),
                child: Text(
                  "${AppStrings.theYear} $index",
                  style: context.textTheme.headlineLarge!
                      .withColor(context.primaryColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
