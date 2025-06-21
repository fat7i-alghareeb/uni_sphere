//!----------------------------  Imports  -------------------------------------!//
import 'package:beamer/beamer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/core/auth_data_source/local/auth_local.dart';
import 'package:test/core/injection/injection.dart';
import 'package:test/core/result_builder/result.dart';
import 'package:test/features/subjects/presentation/state/subjects_bloc/subjects_bloc.dart';
import 'package:test/features/subjects/presentation/ui/screens/year_subjects.dart';
import 'package:test/shared/extensions/string_extension.dart';
import 'package:test/shared/widgets/custom_scaffold_body.dart';

import '../../../../../router/router_config.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../../home/presentation/ui/widgets/decorated_container.dart';
//!----------------------------  Implements  -------------------------------------!//

/// Constants for the ChooseYearsScreen
class _ChooseYearsScreenConstants {
  static int get maxYear {
    try {
      return getIt<AuthLocal>().getUser()?.numberOfMajorYears ?? 0;
    } catch (e) {
      debugPrint('Error getting max year: $e');
      return 0;
    }
  }

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
    try {
      return BlocProvider.value(
        value: getIt<SubjectsBloc>(),
        child: const _ChooseYearsView(),
      );
    } catch (e) {
      debugPrint('Error building ChooseYearsScreen: $e');
      return const Scaffold(
        body: Center(
          child: Text('Something went wrong'),
        ),
      );
    }
  }
}

/// The main view of the ChooseYearsScreen
class _ChooseYearsView extends StatelessWidget {
  const _ChooseYearsView();

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        body: CustomScaffoldBody(
          title: _getMajorName(),
          child: BlocConsumer<SubjectsBloc, SubjectsState>(
            listenWhen: (previous, current) =>
                previous.yearResult != current.yearResult,
            listener: _handleYearResult,
            builder: (context, state) => const _YearsListView(),
          ),
        ),
      );
    } catch (e) {
      debugPrint('Error building ChooseYearsView: $e');
      return const Scaffold(
        body: Center(
          child: Text('Something went wrong'),
        ),
      );
    }
  }

  String _getMajorName() {
    try {
      return getIt<AuthLocal>().getUser()?.majorName ?? "";
    } catch (e) {
      debugPrint('Error getting major name: $e');
      return "";
    }
  }

  void _handleYearResult(BuildContext context, SubjectsState state) {
    try {
      if (state.yearResult.isLoaded()) {
        context.beamToNamed(
          YearSubjects.pagePath,
        );
      }
    } catch (e) {
      debugPrint('Error handling year result: $e');
    }
  }
}

/// A list view that displays all available academic years
class _YearsListView extends StatelessWidget {
  const _YearsListView();

  @override
  Widget build(BuildContext context) {
    try {
      final maxYear = _ChooseYearsScreenConstants.maxYear;
      if (maxYear <= 0) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64.r,
                color: context.primaryColor.withValues(alpha: 0.5),
              ),
              16.verticalSpace,
              Text(
                "No years available",
                style: context.textTheme.titleMedium!.copyWith(
                  color: context.onBackgroundColor.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: REdgeInsets.only(
          left: AppConstants.horizontalScreensPadding,
          right: AppConstants.horizontalScreensPadding,
          top: 10,
          bottom: 50,
        ),
        itemCount: maxYear,
        itemBuilder: (context, index) {
          final year = index + 1;
          return _YearCard(year: year);
        },
      );
    } catch (e) {
      debugPrint('Error building YearsListView: $e');
      return const Center(
        child: Text('Something went wrong'),
      );
    }
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
    try {
      return BlocBuilder<SubjectsBloc, SubjectsState>(
        buildWhen: (previous, current) =>
            previous.yearResult != current.yearResult,
        builder: (context, state) {
          final isLoading = state.yearResult.isLoading() &&
              getIt<SubjectsBloc>().state.selectedYear == year;

          return DecoratedContainer(
            onTap: () => _handleYearSelection(context),
            padding: REdgeInsets.symmetric(vertical: 8),
            circleSize: _ChooseYearsScreenConstants.circleSize,
            animate: isLoading,
            child: Padding(
              padding: REdgeInsets.all(_ChooseYearsScreenConstants.cardPadding),
              child: Text(
                year.yearName,
                style: context.textTheme.headlineLarge!.withColor(
                  context.primaryColor,
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      debugPrint('Error building YearCard: $e');
      return const SizedBox.shrink();
    }
  }

  void _handleYearSelection(BuildContext context) {
    try {
      context.read<SubjectsBloc>()
        ..updateSelectedYear(year)
        ..add(GetYearSubjectsEvent(year));
    } catch (e) {
      debugPrint('Error handling year selection: $e');
    }
  }
}
