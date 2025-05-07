import '../../../../../common/constant/app_strings.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../../home/presentation/ui/widgets/decorated_container.dart';
import '../../state/bloc/subjects_bloc.dart';
import '../widgets/subjects_builder_widget.dart';

/// A screen that displays a list of subjects.
class SubjectsScreen extends StatefulWidget {
  const SubjectsScreen({super.key});

  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  late final SubjectsBloc _subjectsBloc;

  @override
  void initState() {
    super.initState();
    _subjectsBloc = getIt<SubjectsBloc>();
    _subjectsBloc.add(GetSubjectsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _subjectsBloc,
      child: Column(
        children: [
          _buildHeader(context),
          20.verticalSpace,
          _buildDivider(context),
          Expanded(
            child: BlocBuilder<SubjectsBloc, SubjectsState>(
              builder: (context, state) {
                return SubjectsBuilderWidget(state: state.result);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        20.verticalSpace,
        Padding(
          padding: REdgeInsets.symmetric(
            horizontal: AppConstants.horizontalScreensPadding,
          ),
          child: DecoratedContainer(
            circleSize: 100,
            child: Padding(
              padding: REdgeInsets.all(18.0),
              child: Text(
                AppStrings.yourSubjects,
                style: context.textTheme.headlineLarge!
                    .withColor(context.primaryColor),
              ),
            ),
          ),
        ),
      ],
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
