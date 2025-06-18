import '../../../../../common/constant/app_strings.dart';
import '../../../../../core/styles/colors.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../domain/entities/grade_entity.dart';

class GradeCardWidget extends StatelessWidget {
  const GradeCardWidget({
    super.key,
    required this.grade,
  });

  final GradeEntity grade;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: AppColors.primaryShadow(context),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            // Handle tap if needed
          },
          child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Subject Name
                Text(
                  grade.subjectName,
                  style: context.textTheme.titleLarge!.copyWith(
                    color: context.onBackgroundColor,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                16.verticalSpace,
                // Grades Grid
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: _buildGradeItem(
                          context,
                          AppStrings.midTermGrade,
                          grade.midTermGrade.toString(),
                        ),
                      ),
                      6.horizontalSpace,
                      Expanded(
                        child: _buildGradeItem(
                          context,
                          AppStrings.finalTermGrade,
                          grade.finalTermGrade != null
                              ? grade.finalTermGrade.toString()
                              : '--',
                        ),
                      ),
                      6.horizontalSpace,
                      Expanded(
                        child: _buildGradeItem(
                          context,
                          AppStrings.totalGrade,
                          grade.finalTermGrade != null
                              ? grade.totalGrade.toString()
                              : "--",
                          isTotal: true,
                        ),
                      ),
                    ],
                  ),
                ),
                16.verticalSpace,
                // Pass/Fail Status
                Container(
                  padding: REdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: grade.isPassed
                        ? const Color(0xFF1dceb2).withValues(alpha: 0.1)
                        : AppColors.danger.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        grade.isPassed
                            ? Icons.check_circle_outline_rounded
                            : Icons.cancel_outlined,
                        size: 16.r,
                        color: grade.isPassed
                            ? const Color(0xFF1dceb2)
                            : AppColors.danger,
                      ),
                      8.horizontalSpace,
                      Text(
                        grade.isPassed ? AppStrings.passed : AppStrings.failed,
                        style: context.textTheme.labelMedium!.copyWith(
                          color: grade.isPassed
                              ? const Color(0xFF1dceb2)
                              : AppColors.danger,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGradeItem(
    BuildContext context,
    String label,
    String value, {
    bool isTotal = false,
  }) {
    return Container(
      padding: REdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isTotal
            ? context.primaryColor.withValues(alpha: 0.15)
            : context.backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: context.textTheme.labelSmall!.copyWith(
              color: context.onBackgroundColor.withOpacity(0.7),
            ),
          ),
          4.verticalSpace,
          Text(
            value,
            style: context.textTheme.titleLarge!.copyWith(
              color: isTotal ? context.primaryColor : context.onBackgroundColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
