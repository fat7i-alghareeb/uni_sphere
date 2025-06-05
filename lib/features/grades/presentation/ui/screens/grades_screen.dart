//!----------------------------  Imports  -------------------------------------!//
import 'package:beamer/beamer.dart';
import '../../../../../common/constant/app_strings.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../router/router_config.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../../home/presentation/ui/widgets/decorated_container.dart';
import '../../state/bloc/grade_bloc.dart';
import '../widgets/grades_list_widget.dart';

//!---------------------------- The Widget -------------------------------------!//
class GradesScreen extends StatefulWidget {
  const GradesScreen({super.key});

  static const String pagePath = 'grades_screen';

  static BeamerBuilder pageBuilder = (context, state, data) {
    return BeamPage(
      key: ValueKey('grades_screen'),
      child: const GradesScreen(),
      type: BeamPageType.fadeTransition,
    );
  };

  @override
  State<GradesScreen> createState() => _GradesScreenState();
}

class _GradesScreenState extends State<GradesScreen> {
  late final GradeBloc _gradeBloc;

  @override
  void initState() {
    super.initState();
    _gradeBloc = getIt<GradeBloc>();
    _gradeBloc.add(GetGradesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: _gradeBloc,
        child: Column(
          children: [
            40.verticalSpace,
            _buildHeader(context),
            _buildDivider(context),
            Expanded(
              child: BlocBuilder<GradeBloc, GradeState>(
                builder: (context, state) {
                  return GradesListWidget(
                    state: state.result,
                    onRefresh: () async {
                      _gradeBloc.add(GetGradesEvent());
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(
        horizontal: AppConstants.horizontalScreensPadding,
        vertical: 15,
      ),
      child: DecoratedContainer(
        circleSize: 120,
        child: Padding(
          padding: REdgeInsets.all(12.0),
          child: Text(
            AppStrings.yourGrades,
            style: context.textTheme.headlineLarge!
                .withColor(context.primaryColor),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(
        horizontal: AppConstants.horizontalScreensPadding,
      ),
      child: Divider(
        height: 1.h,
        thickness: 1.h,
        color: context.primaryColor.withValues(alpha: 0.5),
      ),
    );
  }
}
