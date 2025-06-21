import '../../../../../common/constant/app_strings.dart' show AppStrings;
import '../../../../../core/result_builder/result.dart';
import '../../../../../core/result_builder/result_builder.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../domain/entities/grade_entity.dart';
import '../../../domain/entities/grades_response_entity.dart'
    show GradesResponseEntity;
import 'grade_year_section.dart';

/// A widget that displays a list of grades organized by year and semester.
/// Uses ResultBuilder to handle different states (loading, success, error)
/// and provides refresh functionality.
class GradesListWidget extends StatefulWidget {
  const GradesListWidget({
    super.key,
    required this.state,
    this.onRefresh,
    this.onError,
  });

  /// The result state containing grades data
  final Result<GradesResponseEntity> state;

  /// Callback function for refresh functionality
  final Future<void> Function()? onRefresh;

  /// Callback function to handle error retry. When provided, uses custom FailedWidget
  /// instead of showOverlay for error display.
  final void Function()? onError;

  @override
  State<GradesListWidget> createState() => _GradesListWidgetState();
}

class _GradesListWidgetState extends State<GradesListWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late List<Animation<double>> _animations = [];
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  void _initializeAnimations(int itemCount) {
    if (_isDisposed) return;

    try {
      _controller.reset();
      _animations = List.generate(
        itemCount,
        (index) => Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(
              index * (0.5 / itemCount),
              (index * (0.5 / itemCount)) + 0.5,
              curve: Curves.easeOut,
            ),
          ),
        ),
      );

      if (!_isDisposed) {
        _controller.forward();
      }
    } catch (e) {
      debugPrint('Error initializing animations: $e');
      _animations = List.generate(
        itemCount,
        (index) => const AlwaysStoppedAnimation(1.0),
      );
    }
  }

  Map<int, Map<int, List<GradeEntity>>> _organizeGrades(
      List<GradeEntity> grades) {
    final organizedGrades = <int, Map<int, List<GradeEntity>>>{};

    for (final grade in grades) {
      // Initialize year map if not exists
      organizedGrades.putIfAbsent(
        grade.subjectYear,
        () => <int, List<GradeEntity>>{},
      );

      // Initialize semester list if not exists
      organizedGrades[grade.subjectYear]!.putIfAbsent(
        grade.subjectSemester,
        () => <GradeEntity>[],
      );

      // Add grade to appropriate semester
      organizedGrades[grade.subjectYear]![grade.subjectSemester]!.add(grade);
    }

    // Sort years in descending order
    final sortedYears = organizedGrades.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    // Sort semesters within each year
    for (final year in sortedYears) {
      final semesters = organizedGrades[year]!.keys.toList()..sort();
      final sortedSemesters = <int, List<GradeEntity>>{};
      for (final semester in semesters) {
        sortedSemesters[semester] = organizedGrades[year]![semester]!;
      }
      organizedGrades[year] = sortedSemesters;
    }

    return organizedGrades;
  }

  @override
  void dispose() {
    _isDisposed = true;
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResultBuilder<GradesResponseEntity>(
      result: widget.state,
      loading: () => _buildLoadingState(),
      success: (gradesResponse) {
        final organizedGrades = _organizeGrades(gradesResponse.grades);
        if (_animations.length != organizedGrades.length) {
          _initializeAnimations(organizedGrades.length);
        }
        return _buildGradesList(organizedGrades);
      },
      onError: widget.onError,
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: context.primaryColor,
          ),
          16.verticalSpace,
          Text(
            AppStrings.loadingGrades,
            style: context.textTheme.titleMedium!.copyWith(
              color: context.onBackgroundColor.withValues(alpha: .7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradesList(
      Map<int, Map<int, List<GradeEntity>>> organizedGrades) {
    return RefreshIndicator(
      onRefresh: widget.onRefresh ?? () async {},
      child: ListView.builder(
        padding: REdgeInsets.only(
          left: AppConstants.horizontalScreensPadding,
          right: AppConstants.horizontalScreensPadding,
          bottom: 100.h,
          top: 40.h,
        ),
        itemBuilder: (context, index) {
          final year = organizedGrades.keys.elementAt(index);
          if (index >= _animations.length) {
            return const SizedBox.shrink();
          }
          return GradeYearSection(
            key: ValueKey('year_$year'),
            year: year,
            semesterGrades: organizedGrades[year]!,
            animation: _animations[index],
          );
        },
        itemCount: organizedGrades.length,
      ),
    );
  }
}
