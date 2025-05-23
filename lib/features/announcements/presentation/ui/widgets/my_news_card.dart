import 'package:test/features/announcements/domain/entities/announcement_entity.dart';
import '../../../../../core/styles/colors.dart';
import '../../../../../shared/imports/imports.dart';

class MyNewsCard extends StatelessWidget {
  const MyNewsCard({
    super.key,
    required this.announcementEntity,
  });

  final AnnouncementEntity announcementEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsets.only(bottom: 22.h),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: AppColors.primaryShadow(context),
      ),
      child: Padding(
        padding: REdgeInsets.all(22.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              announcementEntity.createdAt,
              style: context.textTheme.labelMedium?.copyWith(
                color: context.greyColor,
              ),
            ),
            12.verticalSpace,
            Text(
              announcementEntity.title,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.onBackgroundColor,
              ),
            ),
            8.verticalSpace,
            Text(
              announcementEntity.description,
              style: context.textTheme.bodyLarge?.copyWith(
                wordSpacing: 1.8,
                height: 1.5,
                letterSpacing: 0.4,
                color: context.onBackgroundColor.withOpacity(0.95),
              ),
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
