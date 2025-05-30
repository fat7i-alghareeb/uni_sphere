import 'package:test/common/constant/app_strings.dart';
import 'package:test/shared/imports/imports.dart';
import '../../../../../shared/widgets/custom_shimmer.dart';
import '../../../domain/entities/subject_details_entity.dart';

class SubjectDetailsHeader extends StatelessWidget {
  const SubjectDetailsHeader({
    super.key,
    required this.subjectDetails,
  });

  final SubjectDetailsEntity subjectDetails;

  static const double _borderRadius = 22;
  static const double _spacing = 16;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(
        horizontal: AppConstants.horizontalScreensPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfessorInfo(context),
          _spacing.verticalSpace,
          _buildSubjectInfo(context),
        ],
      ),
    );
  }

  Widget _buildProfessorInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.Professor,
          style: context.textTheme.titleMedium!.withColor(context.primaryColor),
        ),
        8.verticalSpace,
        Text(
          subjectDetails.professorName,
          style:
              context.textTheme.bodyLarge!.withColor(context.onBackgroundColor),
        ),
        8.verticalSpace,
        Text(
          subjectDetails.professorIntro,
          style: context.textTheme.bodyMedium!.withColor(context.greyColor),
        ),
      ],
    );
  }

  Widget _buildSubjectInfo(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(_borderRadius.r),
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
            AppStrings.SubjectInformation,
            style:
                context.textTheme.titleMedium!.withColor(context.primaryColor),
          ),
          16.verticalSpace,
          _buildInfoRow(context, AppStrings.Semester, subjectDetails.semester),
          8.verticalSpace,
          _buildInfoRow(
            context,
            AppStrings.Status,
            subjectDetails.isPassed ? AppStrings.Passed : AppStrings.NotPassed,
            color: subjectDetails.isPassed ? Colors.green : Colors.red,
          ),
          8.verticalSpace,
          _buildInfoRow(
            context,
            AppStrings.Enrollment,
            subjectDetails.canEnroll
                ? AppStrings.Available
                : AppStrings.NotAvailable,
            color: subjectDetails.canEnroll ? Colors.green : Colors.red,
          ),
          8.verticalSpace,
          _buildInfoRow(
            context,
            AppStrings.Type,
            subjectDetails.isMultipleChoice
                ? AppStrings.MultipleChoice
                : AppStrings.Written,
          ),
          8.verticalSpace,
          _buildInfoRow(
            context,
            AppStrings.ContainedLab,
            subjectDetails.doesHaveALab ? AppStrings.yes : AppStrings.no,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value, {
    Color? color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.textTheme.bodyMedium!.withColor(context.greyColor),
        ),
        Text(
          value,
          style: context.textTheme.bodyMedium!.withColor(
            color ?? context.onBackgroundColor,
          ),
        ),
      ],
    );
  }

  static Widget buildHeaderShimmer(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(AppConstants.horizontalScreensPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Professor info shimmer
          Container(
            height: 24.h,
            width: 100.w,
            decoration: BoxDecoration(
              color: context.cardColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: CustomShimmerWidget(
              height: 24.h,
              width: 100.w,
              borderRadius: 8,
            ),
          ),
          8.verticalSpace,
          Container(
            height: 20.h,
            width: 150.w,
            decoration: BoxDecoration(
              color: context.cardColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: CustomShimmerWidget(
              height: 20.h,
              width: 150.w,
              borderRadius: 8,
            ),
          ),
          8.verticalSpace,
          Container(
            height: 16.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: context.cardColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: CustomShimmerWidget(
              height: 16.h,
              width: double.infinity,
              borderRadius: 8,
            ),
          ),
          16.verticalSpace,
          // Subject info card shimmer
          Container(
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
                Container(
                  height: 24.h,
                  width: 150.w,
                  decoration: BoxDecoration(
                    color: context.cardColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: CustomShimmerWidget(
                    height: 24.h,
                    width: 150.w,
                    borderRadius: 8,
                  ),
                ),
                16.verticalSpace,
                ...List.generate(
                    5,
                    (index) => Padding(
                          padding: REdgeInsets.only(bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 16.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                  color: context.cardColor,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: CustomShimmerWidget(
                                  height: 16.h,
                                  width: 100.w,
                                  borderRadius: 8,
                                ),
                              ),
                              Container(
                                height: 16.h,
                                width: 80.w,
                                decoration: BoxDecoration(
                                  color: context.cardColor,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: CustomShimmerWidget(
                                  height: 16.h,
                                  width: 80.w,
                                  borderRadius: 8,
                                ),
                              ),
                            ],
                          ),
                        )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
