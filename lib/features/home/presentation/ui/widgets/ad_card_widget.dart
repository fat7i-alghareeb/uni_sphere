import 'package:test/core/styles/app_text_theme.dart';

import '../../../../../shared/imports/imports.dart';
import '../../../../../shared/widgets/custom_network_image.dart';
import '../../../domain/entities/ads_entity.dart';
import '../constants/ads_constants.dart';

class AdCardWidget extends StatelessWidget {
  final AdsEntity ad;

  const AdCardWidget({
    super.key,
    required this.ad,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.none,
      margin: REdgeInsets.symmetric(horizontal: AdsConstants.horizontalMargin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AdsConstants.borderRadius.r),
        boxShadow: AdsConstants.cardShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AdsConstants.borderRadius.r),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CustomNetworkImage(
              imageUrl: ad.imageUrl,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: AdsConstants.overlayGradient,
              ),
            ),
            Positioned(
              left: AdsConstants.contentPadding.w,
              right: AdsConstants.contentPadding.w,
              bottom: AdsConstants.contentPadding.h,
              child: Text(
                ad.description,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
