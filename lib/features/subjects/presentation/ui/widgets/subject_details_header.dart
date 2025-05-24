import 'package:test/shared/imports/imports.dart';
import 'package:test/shared/widgets/custom_network_image.dart';
import '../../../domain/entities/subject_details_entity.dart';

class SubjectDetailsHeader extends StatelessWidget {
  const SubjectDetailsHeader({
    super.key,
    required this.subjectDetails,
  });

  final SubjectDetailsEntity subjectDetails;

  static const double _imageSize = 200;
  static const double _borderRadius = 22;
  static const double _spacing = 16;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(AppConstants.horizontalScreensPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(context),
          _spacing.verticalSpace,
          _buildTitle(context),
          _spacing.verticalSpace,
          _buildProfessorInfo(context),
          _spacing.verticalSpace,
          _buildSubjectInfo(context),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Center(
      child: Container(
        height: _imageSize.h,
        width: _imageSize.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_borderRadius.r),
          boxShadow: [
            BoxShadow(
              color: context.primaryColor.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_borderRadius.r),
          child: CustomNetworkImage(
            imageUrl: subjectDetails.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      subjectDetails.title,
      style: context.textTheme.headlineMedium!.withColor(context.primaryColor),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildProfessorInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Professor',
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
            color: context.primaryColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Subject Information',
            style:
                context.textTheme.titleMedium!.withColor(context.primaryColor),
          ),
          16.verticalSpace,
          _buildInfoRow(context, 'Semester', subjectDetails.semester),
          8.verticalSpace,
          _buildInfoRow(
            context,
            'Status',
            subjectDetails.isPassed ? 'Passed' : 'Not Passed',
            color: subjectDetails.isPassed ? Colors.green : Colors.red,
          ),
          8.verticalSpace,
          _buildInfoRow(
            context,
            'Enrollment',
            subjectDetails.canEnroll ? 'Available' : 'Not Available',
            color: subjectDetails.canEnroll ? Colors.green : Colors.red,
          ),
          8.verticalSpace,
          _buildInfoRow(
            context,
            'Type',
            subjectDetails.isMultipleChoice ? 'Multiple Choice' : 'Written',
          ),
          8.verticalSpace,
          _buildInfoRow(
            context,
            'Lab',
            subjectDetails.doesHaveALab ? 'Available' : 'Not Available',
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
}
