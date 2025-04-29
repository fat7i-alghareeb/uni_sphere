import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/result_builder/result_builder.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../../../shared/widgets/custom_network_image.dart';
import '../../../../../shared/widgets/custom_shimmer.dart';
import '../../../domain/entities/ads_entity.dart';
import '../../../domain/entities/home_entity.dart';
import '../../state/bloc/home_bloc.dart';

class AdsWidget extends StatelessWidget {
  const AdsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return ResultBuilder<HomeEntity>(
          result: state.result,
          success: (data) => _buildAdsSlider(context, data.ads),
          loading: () => _buildAdsSliderLoading(context),
        );
      },
    );
  }

  Widget _buildAdsSliderLoading(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 3,
      options: CarouselOptions(
        height: 180.h,
        aspectRatio: 16 / 9,
        viewportFraction: 0.9,
        enableInfiniteScroll: false,
        scrollDirection: Axis.horizontal,
      ),
      itemBuilder: (context, index, realIndex) {
        return Container(
          margin: REdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: context.shimmerColor,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Stack(
              fit: StackFit.expand,
              children: [
                CustomShimmerWidget(
                  padding: REdgeInsets.all(0),
                  borderRadius: 16.r,
                ),
                Positioned(
                  left: 16.w,
                  right: 16.w,
                  bottom: 16.h,
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

  Widget _buildAdsSlider(BuildContext context, List<AdsEntity> ads) {
    return CarouselSlider.builder(
      itemCount: ads.length,
      options: CarouselOptions(
        clipBehavior: Clip.none,
        height: 180.h,
        aspectRatio: 16 / 9,
        viewportFraction: 0.9,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        scrollDirection: Axis.horizontal,
      ),
      itemBuilder: (context, index, realIndex) {
        final ad = ads[index];
        return _buildAdCard(context, ad);
      },
    );
  }

  Widget _buildAdCard(BuildContext context, AdsEntity ad) {
    return Container(
      clipBehavior: Clip.none,
      margin: REdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: context.onBackgroundColor.withOpacity(0.1),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CustomNetworkImage(
              imageUrl: ad.imageUrl,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 16.w,
              right: 16.w,
              bottom: 16.h,
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
