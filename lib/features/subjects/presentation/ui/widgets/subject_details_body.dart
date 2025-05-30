import 'package:test/shared/imports/imports.dart';
import '../../../domain/entities/subject_details_entity.dart';
import 'material_item_card.dart';

class SubjectDetailsBody extends StatelessWidget {
  const SubjectDetailsBody({
    super.key,
    required this.subjectDetails,
  });

  final SubjectDetailsEntity subjectDetails;

  static const double _borderRadius = 22;
  static const double _spacing = 16;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(AppConstants.horizontalScreensPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDescription(context),
          _spacing.verticalSpace,
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
        children: [
          Text(
            'Description',
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

  Widget _buildMaterials(BuildContext context) {
    if (subjectDetails.materials.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Materials',
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
}
