import 'package:test/common/constant/app_strings.dart';
import 'package:test/features/subjects/domain/entities/subject_details_entity.dart';
import 'package:test/shared/imports/imports.dart';
import 'materials_list_card.dart';

class SubjectDescriptionWithMaterials extends StatelessWidget {
  const SubjectDescriptionWithMaterials({
    super.key,
    required this.subjectDetails,
  });

  final SubjectDetailsEntity subjectDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(
        horizontal: AppConstants.horizontalScreensPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSubjectDescriptionCard(context),
          18.verticalSpace,
          MaterialsListCard(materials: subjectDetails.materials),
        ],
      ),
    );
  }

  Widget _buildSubjectDescriptionCard(BuildContext context) {
    return Container(
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
            'Subject Description',
            style:
                context.textTheme.titleMedium!.withColor(context.primaryColor),
          ),
          16.verticalSpace,
          Text(
            subjectDetails.subjectDescription,
            style: context.textTheme.bodyMedium!
                .withColor(context.onBackgroundColor),
          ),
        ],
      ),
    );
  }

  static Widget buildBodyShimmer(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(
        horizontal: AppConstants.horizontalScreensPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  height: 20.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                    color: context.greyColor.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                16.verticalSpace,
                Container(
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: context.greyColor.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ],
            ),
          ),
          18.verticalSpace,
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
                  height: 20.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: context.greyColor.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                16.verticalSpace,
                Container(
                  height: 80.h,
                  decoration: BoxDecoration(
                    color: context.greyColor.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
