import '../../../../../common/constant/app_strings.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../../../shared/widgets/custom_shimmer.dart';
import '../../../domain/entities/subject_details_entity.dart';
import 'material_item_card.dart';

class SubjectDescriptionWithMaterials extends StatelessWidget {
  const SubjectDescriptionWithMaterials({
    super.key,
    required this.subjectDetails,
  });

  final SubjectDetailsEntity subjectDetails;

  static const double _borderRadius = 22;
  static const double _spacing = 18;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.symmetric(
        horizontal: AppConstants.horizontalScreensPadding,
      ),
      child: Column(
        spacing: _spacing.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDescription(context),
          // _spacing.verticalSpace,
          _buildMaterials(context),
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
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
        spacing: 16.h,
        children: [
          Text(
            AppStrings.Description,
            style:
                context.textTheme.titleMedium!.withColor(context.primaryColor),
          ),
          Text(
            subjectDetails.subjectDescription,
            style: context.textTheme.bodyMedium!
                .withColor(context.onBackgroundColor),
          ),
        ],
      ),
    );
  }

  Widget _buildMaterials(BuildContext context) {
    if (subjectDetails.materials.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.Materials,
          style: context.textTheme.titleMedium!.withColor(context.primaryColor),
        ),
        16.verticalSpace,
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: subjectDetails.materials.length,
          separatorBuilder: (context, index) => 8.verticalSpace,
          itemBuilder: (context, index) {
            final material = subjectDetails.materials[index];
            return MaterialItemCard(material: material);
          },
        ),
      ],
    );
  }

  static Widget buildBodyShimmer(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(AppConstants.horizontalScreensPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description card shimmer
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
                  width: 120.w,
                  decoration: BoxDecoration(
                    color: context.cardColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: CustomShimmerWidget(
                    height: 24.h,
                    width: 120.w,
                    borderRadius: 8,
                  ),
                ),
                16.verticalSpace,
                ...List.generate(
                    4,
                    (index) => Padding(
                          padding: REdgeInsets.only(bottom: 8),
                          child: Container(
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
                        )),
              ],
            ),
          ),
          16.verticalSpace,
          // Materials section shimmer
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
          16.verticalSpace,
          ...List.generate(
              3,
              (index) => Padding(
                    padding: REdgeInsets.only(bottom: 8),
                    child: Container(
                      padding: REdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: context.cardColor,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: context.primaryColor.withValues(alpha: 0.1),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 40.h,
                            width: 40.w,
                            decoration: BoxDecoration(
                              color: context.cardColor,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: CustomShimmerWidget(
                              height: 40.h,
                              width: 40.w,
                              borderRadius: 8,
                            ),
                          ),
                          16.horizontalSpace,
                          Expanded(
                            child: Container(
                              height: 20.h,
                              decoration: BoxDecoration(
                                color: context.cardColor,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: CustomShimmerWidget(
                                height: 20.h,
                                width: double.infinity,
                                borderRadius: 8,
                              ),
                            ),
                          ),
                          16.horizontalSpace,
                          Container(
                            height: 24.h,
                            width: 24.w,
                            decoration: BoxDecoration(
                              color: context.cardColor,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: CustomShimmerWidget(
                              height: 24.h,
                              width: 24.w,
                              borderRadius: 8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
        ],
      ),
    );
  }
}
