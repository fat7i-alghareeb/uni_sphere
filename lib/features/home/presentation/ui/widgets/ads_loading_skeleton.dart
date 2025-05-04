import 'package:carousel_slider/carousel_slider.dart';

import '../../../../../shared/imports/imports.dart';
import '../../../../../shared/widgets/custom_shimmer.dart';
import '../constants/ads_constants.dart';

class AdsLoadingSkeleton extends StatelessWidget {
  const AdsLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 3,
      options: CarouselOptions(
        height: AdsConstants.carouselHeight.h,
        aspectRatio: AdsConstants.carouselAspectRatio,
        viewportFraction: AdsConstants.viewportFraction,
        enableInfiniteScroll: false,
        scrollDirection: Axis.horizontal,
      ),
      itemBuilder: (context, index, realIndex) {
        return Container(
          margin:
              REdgeInsets.symmetric(horizontal: AdsConstants.horizontalMargin),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AdsConstants.borderRadius.r),
            color: context.shimmerColor,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AdsConstants.borderRadius.r),
            child: Stack(
              fit: StackFit.expand,
              children: [
                CustomShimmerWidget(
                  padding: REdgeInsets.all(0),
                  borderRadius: AdsConstants.borderRadius.r,
                ),
                Positioned(
                  left: AdsConstants.contentPadding.w,
                  right: AdsConstants.contentPadding.w,
                  bottom: AdsConstants.contentPadding.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomShimmerWidget(
                        padding: REdgeInsets.only(bottom: 4),
                        height: 16,
                        width: double.infinity,
                        borderRadius: 8.r,
                      ),
                      CustomShimmerWidget(
                        padding: REdgeInsets.all(0),
                        height: 16,
                        width: 150,
                        borderRadius: 8.r,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
