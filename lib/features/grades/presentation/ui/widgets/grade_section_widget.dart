import '../../../../../common/constant/app_strings.dart';
import '../../../../../shared/extensions/string_extension.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../domain/entities/grade_entity.dart';
import 'grade_card_widget.dart';

class GradeSectionWidget extends StatefulWidget {
  const GradeSectionWidget({
    super.key,
    required this.year,
    required this.semesterGrades,
    this.onYearExpanded,
    this.onSemesterExpanded,
    this.isLoading = false,
  });

  final int year;
  final Map<int, List<GradeEntity>> semesterGrades;
  final Function(bool)? onYearExpanded;
  final Function(int, bool)? onSemesterExpanded;
  final bool isLoading;

  @override
  State<GradeSectionWidget> createState() => _GradeSectionWidgetState();
}

class _GradeSectionWidgetState extends State<GradeSectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        initiallyExpanded: false,
        onExpansionChanged: widget.onYearExpanded,
        backgroundColor: context.cardColor,
        collapsedBackgroundColor: context.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          widget.year.yearName,
          style: context.textTheme.titleLarge!.copyWith(
            color: context.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: widget.semesterGrades.entries.map((semesterEntry) {
          final semester = semesterEntry.key;
          final grades = semesterEntry.value;

          return _SemesterSection(
            key: ValueKey('semester_${widget.year}_$semester'),
            semester: semester,
            grades: grades,
            isLoading: widget.isLoading,
            onExpanded: (expanded) {
              widget.onSemesterExpanded?.call(semester, expanded);
            },
          );
        }).toList(),
      ),
    );
  }
}

class _SemesterSection extends StatefulWidget {
  const _SemesterSection({
    super.key,
    required this.semester,
    required this.grades,
    required this.isLoading,
    required this.onExpanded,
  });

  final int semester;
  final List<GradeEntity> grades;
  final bool isLoading;
  final Function(bool) onExpanded;

  @override
  State<_SemesterSection> createState() => _SemesterSectionState();
}

class _SemesterSectionState extends State<_SemesterSection>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: REdgeInsets.only(
        left: 16.w,
        right: 16.w,
        bottom: 8.h,
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          key: ValueKey('semester_expansion_${widget.semester}'),
          initiallyExpanded: false,
          onExpansionChanged: widget.onExpanded,
          backgroundColor: context.backgroundColor,
          collapsedBackgroundColor: context.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          title: Text(
            widget.semester.semesterName,
            style: context.textTheme.titleMedium!.copyWith(
              color: context.onBackgroundColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          children: [
            if (widget.isLoading)
              Padding(
                padding: REdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        width: 24.w,
                        height: 24.h,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.w,
                          color: context.primaryColor,
                        ),
                      ),
                      8.verticalSpace,
                      Text(
                        AppStrings.loadingGrades,
                        style: context.textTheme.bodySmall!.copyWith(
                          color:
                              context.onBackgroundColor.withValues(alpha: .7),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              ...widget.grades.map((grade) => Padding(
                    padding: REdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                      bottom: 8.h,
                    ),
                    child: GradeCardWidget(
                      key: ValueKey('grade_${grade.subjectName}_${grade.subjectYear}_${grade.subjectSemester}'),
                      grade: grade,
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}
