import 'package:test/features/announcements/domain/entities/announcement_entity.dart';
import 'package:test/shared/widgets/custom_network_image.dart';

import '../../../../../core/styles/colors.dart';
import '../../../../../shared/imports/imports.dart';

class AllNewsCard extends StatelessWidget {
  const AllNewsCard({super.key, required this.announcementEntity});
  final AnnouncementEntity announcementEntity;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      margin: REdgeInsets.only(bottom: 22.h),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: AppColors.primaryShadow(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: AppColors.primaryShadow(context),
            ),
            child: CustomNetworkImage(
              imageUrl: announcementEntity.image,
              height: 180.h,
              width: double.infinity,
              borderRadius: 22,
            ),
          ),
          Expanded(
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 22.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    announcementEntity.createdAt,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: context.greyColor,
                    ),
                  ),
                  5.verticalSpace,
                  Expanded(
                    child: Text(
                      announcementEntity.description,
                      style: context.textTheme.labelLarge!.copyWith(
                        wordSpacing: 1.8,
                        height: 1.5,
                        letterSpacing: 0.4,
                        fontWeight: FontWeight.w900,
                        color: context.onBackgroundColor.withOpacity(0.95),
                      ),
                      softWrap: true,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
