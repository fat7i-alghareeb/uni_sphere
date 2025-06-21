import '../../../../../common/constant/app_strings.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../domain/entities/subject_details_entity.dart';

class SubjectDetailsGrades extends StatelessWidget {
  const SubjectDetailsGrades({
    super.key,
    required this.subjectDetails,
  });

  final SubjectDetailsEntity subjectDetails;

  @override
  Widget build(BuildContext context) {
    final totalGrade =
        (subjectDetails.midTermGrade ?? 0) + (subjectDetails.finalGrade ?? 0);
    return Container(
      margin: REdgeInsets.symmetric(
        horizontal: AppConstants.horizontalScreensPadding,
      ),
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(
            color: context.primaryColor.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.theGrade,
            style: context.textTheme.titleLarge?.copyWith(
              color: context.onBackgroundColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          16.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (subjectDetails.midTermGrade != null) ...[
                _buildGradeItem(
                  context,
                  AppStrings.midTermGrade,
                  subjectDetails.midTermGrade.toString(),
                ),
              ],
              if (subjectDetails.finalGrade != null) ...[
                _buildGradeItem(
                  context,
                  AppStrings.finalGrade,
                  subjectDetails.finalGrade.toString(),
                ),
              ],
              _buildGradeItem(
                context,
                AppStrings.TotalGrade,
                totalGrade.toString(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGradeItem(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: context.textTheme.labelMedium?.copyWith(
            color: context.greyColor,
          ),
        ),
        8.verticalSpace,
        Text(
          value,
          style: context.textTheme.titleLarge?.copyWith(
            color: context.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
