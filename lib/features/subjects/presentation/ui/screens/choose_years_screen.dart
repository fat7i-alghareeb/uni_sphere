//!----------------------------  Imports  -------------------------------------!//
import 'package:beamer/beamer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/common/constant/app_strings.dart';
import 'package:test/core/injection/injection.dart';
import 'package:test/core/result_builder/result.dart';
import 'package:test/features/subjects/presentation/state/bloc/subjects_bloc.dart';
import 'package:test/features/subjects/presentation/ui/screens/year_subjects.dart';
import 'package:test/shared/widgets/custom_scaffold_body.dart';
import '../../../../../router/router_config.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../../home/presentation/ui/widgets/decorated_container.dart';

/// Constants for the ChooseYearsScreen
class _ChooseYearsScreenConstants {
  static const int minYear = 1;
  static const int maxYear = 4;
  static const double cardPadding = 12.0;
  static const double circleSize = 130.0;
}

/// A screen that allows users to choose their academic year.
/// Displays a list of years from 1 to 4 for Computer Engineering students.
class ChooseYearsScreen extends StatefulWidget {
  const ChooseYearsScreen({super.key});

  static const String pagePath = 'choose_years_screen';

  static BeamerBuilder pageBuilder = (context, state, data) {
    return BeamPage(
      key: ValueKey(
          'choose_years_screen:${DateTime.now().millisecondsSinceEpoch}'),
      child: const ChooseYearsScreen(),
      type: BeamPageType.fadeTransition,
    );
  };

  @override
  State<ChooseYearsScreen> createState() => _ChooseYearsScreenState();
}

class _ChooseYearsScreenState extends State<ChooseYearsScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SubjectsBloc>(),
      child: const _ChooseYearsView(),
    );
  }
}

/// The main view of the ChooseYearsScreen
class _ChooseYearsView extends StatelessWidget {
  const _ChooseYearsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScaffoldBody(
        title: "Computer Engineering",
        child: BlocConsumer<SubjectsBloc, SubjectsState>(
          listenWhen: (previous, current) =>
              previous.yearResult != current.yearResult,
          listener: _handleYearResult,
          builder: (context, state) => const _YearsListView(),
        ),
      ),
    );
  }

  void _handleYearResult(BuildContext context, SubjectsState state) {
    if (state.yearResult.isLoaded()) {
      final subjects = state.yearResult.getDataWhenSuccess();
      context.beamToNamed(
        YearSubjects.pagePath,
        data: subjects,
      );
    }
  }
}

/// A list view that displays all available academic years
class _YearsListView extends StatelessWidget {
  const _YearsListView();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: REdgeInsets.only(
        left: AppConstants.horizontalScreensPadding,
        right: AppConstants.horizontalScreensPadding,
        top: 30,
        bottom: 50,
      ),
      itemCount: _ChooseYearsScreenConstants.maxYear,
      itemBuilder: (context, index) {
        final year = index + 1;
        return _YearCard(year: year);
      },
    );
  }
}

/// A card widget that represents a single academic year
class _YearCard extends StatelessWidget {
  const _YearCard({
    required this.year,
  });

  final int year;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubjectsBloc, SubjectsState>(
      buildWhen: (previous, current) =>
          previous.yearResult != current.yearResult,
      builder: (context, state) {
        final isLoading = state.yearResult.isLoading() &&
            context.read<SubjectsBloc>().state.selectedYear == year;

        return DecoratedContainer(
          onTap: () => _handleYearSelection(context),
          padding: REdgeInsets.symmetric(vertical: 8),
          circleSize: _ChooseYearsScreenConstants.circleSize,
          animate: isLoading,
          child: Padding(
            padding: REdgeInsets.all(_ChooseYearsScreenConstants.cardPadding),
            child: Text(
              "${AppStrings.theYear} $year",
              style: context.textTheme.headlineLarge!.withColor(
                context.primaryColor,
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleYearSelection(BuildContext context) {
    context.read<SubjectsBloc>()
      ..updateSelectedYear(year)
      ..add(GetYearSubjectsEvent(year));
  }
}
