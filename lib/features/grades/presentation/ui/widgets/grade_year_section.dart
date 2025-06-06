import '../../../../../shared/imports/imports.dart';
import '../../../domain/entities/grade_entity.dart';
import 'grade_section_widget.dart';

class GradeYearSection extends StatefulWidget {
  const GradeYearSection({
    super.key,
    required this.year,
    required this.semesterGrades,
    required this.animation,
  });

  final int year;
  final Map<int, List<GradeEntity>> semesterGrades;
  final Animation<double> animation;

  @override
  State<GradeYearSection> createState() => _GradeYearSectionState();
}

class _GradeYearSectionState extends State<GradeYearSection>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  late final AnimationController _expandController;
  late final Animation<double> _expandAnimation;
  final Map<int, bool> _expandedSemesters = {};

  @override
  void initState() {
    super.initState();
    _expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _expandAnimation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _expandController.dispose();
    super.dispose();
  }

  void _handleExpansionChanged(bool expanded) {
    if (expanded) {
      _expandController.forward();
    } else {
      _expandController.reverse();
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnimatedBuilder(
      animation: widget.animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -20 * (1 - widget.animation.value)),
          child: Opacity(
            opacity: widget.animation.value,
            child: child,
          ),
        );
      },
      child: Padding(
        padding: REdgeInsets.only(bottom: 16.h),
        child: AnimatedBuilder(
          animation: _expandAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: 0.95 + (0.05 * _expandAnimation.value),
              child: Opacity(
                opacity: 0.9 + (0.1 * _expandAnimation.value),
                child: child,
              ),
            );
          },
          child: GradeSectionWidget(
            year: widget.year,
            semesterGrades: widget.semesterGrades,
            onYearExpanded: _handleExpansionChanged,
            onSemesterExpanded: (semester, expanded) {
              setState(() {
                _expandedSemesters[semester] = expanded;
              });
            },
          ),
        ),
      ),
    );
  }
}
