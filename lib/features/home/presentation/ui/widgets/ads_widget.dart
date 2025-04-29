import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/result_builder/result_builder.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../domain/entities/ads_entity.dart';
import '../../../domain/entities/home_entity.dart';
import '../../state/bloc/home_bloc.dart';
import '../constants/ads_constants.dart';
import 'ad_card_widget.dart';
import 'ads_loading_skeleton.dart';

/// A widget that displays a carousel of advertisements.
///
/// This widget uses [CarouselSlider] to display a list of ads in a horizontal
/// carousel format. It handles both loading and loaded states, showing a
/// skeleton loading animation when the data is being fetched.
class AdsWidget extends StatelessWidget {
  const AdsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return ResultBuilder<HomeEntity>(
          result: state.result,
          success: (data) => _buildAdsSlider(context, data.ads),
          loading: () => const AdsLoadingSkeleton(),
        );
      },
    );
  }

  Widget _buildAdsSlider(BuildContext context, List<AdsEntity> ads) {
    return CarouselSlider.builder(
      itemCount: ads.length,
      options: CarouselOptions(
        clipBehavior: Clip.none,
        height: AdsConstants.carouselHeight.h,
        aspectRatio: AdsConstants.carouselAspectRatio,
        viewportFraction: AdsConstants.viewportFraction,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: AdsConstants.autoPlayInterval,
        autoPlayAnimationDuration: AdsConstants.autoPlayAnimationDuration,
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: AdsConstants.enlargeFactor,
        scrollDirection: Axis.horizontal,
      ),
      itemBuilder: (context, index, realIndex) {
        return AdCardWidget(ad: ads[index]);
      },
    );
  }
}
