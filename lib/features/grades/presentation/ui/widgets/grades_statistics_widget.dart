import 'package:easy_localization/easy_localization.dart'
    show StringTranslateExtension;
import '../../../../../common/constant/app_strings.dart';
import '../../../../../core/styles/colors.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../domain/entities/grades_response_entity.dart';

class GradesStatisticsWidget extends StatelessWidget {
  const GradesStatisticsWidget({
    super.key,
    required this.gradesResponse,
    required this.animation,
  });

  final GradesResponseEntity gradesResponse;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -20 * (1 - animation.value)),
          child: Opacity(
            opacity: animation.value,
            child: child,
          ),
        );
      },
      child: Container(
        margin: REdgeInsets.symmetric(
          horizontal: AppConstants.horizontalScreensPadding,
          vertical: 16,
        ),
        padding: REdgeInsets.symmetric(horizontal: 12, vertical: 20),
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: BorderRadius.circular(22.r),
          boxShadow: AppColors.primaryShadow(context),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              AppStrings.yourGrades.tr(),
              style: context.textTheme.headlineLarge!.copyWith(
                color: context.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            24.verticalSpace,
            // Statistics Grid
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: _buildStatCard(
                      context,
                      AppStrings.passedSubjects,
                      gradesResponse.numberOfPassedSubjects.toString(),
                      const Color(0xFF1dceb2),
                    ),
                  ),
                  8.horizontalSpace,
                  Expanded(
                    child: _buildStatCard(
                      context,
                      AppStrings.failedSubjects,
                      gradesResponse.numberOfFailedSubjects.toString(),
                      AppColors.danger,
                    ),
                  ),
                ],
              ),
            ),
            16.verticalSpace,
            // Average Grade Card
            Container(
              width: double.infinity,
              padding: REdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.averageGrade,
                          style: context.textTheme.titleSmall!.copyWith(
                            color: context.onBackgroundColor.withOpacity(0.7),
                          ),
                        ),
                        4.verticalSpace,
                        Text(
                          gradesResponse.averageGrade.toStringAsFixed(2),
                          style: context.textTheme.headlineSmall!.copyWith(
                            color: context.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String label,
    String value,
    Color color,
  ) {
    return Container(
      padding: REdgeInsets.symmetric(horizontal: 10, vertical: 16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            label,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.titleSmall!.copyWith(
              color: context.onBackgroundColor.withValues(alpha: 0.7),
            ),
          ),
          12.verticalSpace,
          Text(
            value,
            style: context.textTheme.headlineSmall!.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
