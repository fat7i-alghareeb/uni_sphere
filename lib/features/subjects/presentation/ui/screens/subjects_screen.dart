import 'package:beamer/beamer.dart';
import 'package:test/shared/utils/helper/colored_print.dart';

import '../../../../../common/constant/app_strings.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../../home/presentation/ui/widgets/decorated_container.dart';
import '../../state/bloc/subjects_bloc.dart';
import '../widgets/subjects_builder_widget.dart';
import 'choose_years_screen.dart';

/// A screen that displays a list of subjects.
class SubjectsScreen extends StatefulWidget {
  const SubjectsScreen({super.key});

  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen>
    with AutomaticKeepAliveClientMixin {
  late final SubjectsBloc _subjectsBloc;

  @override
  void initState() {
    super.initState();
    _subjectsBloc = getIt<SubjectsBloc>();
    _subjectsBloc.add(GetSubjectsEvent());
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    printR("disposing");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
      create: (context) => _subjectsBloc,
      child: Column(
        children: [
          _buildHeader(context),
          _buildDivider(context),
          Expanded(
            child: BlocBuilder<SubjectsBloc, SubjectsState>(
              builder: (context, state) {
                return SubjectsBuilderWidget(
                  state: state.result,
                  onRefresh: () async {
                    _subjectsBloc.add(
                      GetSubjectsEvent(),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(
        horizontal: AppConstants.horizontalScreensPadding,
        vertical: 20,
      ),
      child: DecoratedContainer(
        onTap: () => context.beamToNamed(ChooseYearsScreen.pagePath),
        circleSize: 120,
        child: Padding(
          padding: REdgeInsets.all(12.0),
          child: Text(
            AppStrings.yourSubjects,
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
        color: context.primaryColor.withOpacity(0.5),
      ),
    );
  }
}
