import '../../../../../core/result_builder/result.dart';
import '../../../../../core/styles/colors.dart';

import '../../../../../common/constant/app_strings.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../../../shared/utils/helper/get_colored_svg_picture.dart';
import '../../../../../shared/widgets/dot_loading_indicator.dart';
import '../../../domain/entities/statistics_entity.dart';
import '../../state/bloc/home_bloc.dart';

/// A single statistics card that displays a specific type of statistic.
class StatisticsCard extends StatelessWidget {
  final StatisticsCardType type;

  const StatisticsCard({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final cardData = _getCardData(type);

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final value = _getStatisticValue(state, type);

        return _StatisticsCardContent(
          title: cardData.title,
          value: value,
          icon: cardData.icon,
          color: cardData.color,
          isLoading: state.result.isLoading(),
        );
      },
    );
  }

  String _getStatisticValue(HomeState state, StatisticsCardType type) {
    if (!state.result.isLoaded()) return '';

    final statistics = state.result.getDataWhenSuccess()?.statistics;
    switch (type) {
      case StatisticsCardType.attendanceHours:
        return statistics?.numberOfAttendanceHours.toString() ?? '';
      case StatisticsCardType.attendanceLectures:
        return statistics?.numberOfAttendanceLectures.toString() ?? '';
      case StatisticsCardType.daysToTheFinals:
        return statistics?.numberOfDaysToTheFinals.toString() ?? '';
      case StatisticsCardType.downloadedMaterials:
        return statistics?.numberOfDownloadedMaterials.toString() ?? '';
    }
  }

  _CardData _getCardData(StatisticsCardType type) {
    switch (type) {
      case StatisticsCardType.attendanceHours:
        return _CardData(
          title: AppStrings.numberOfAttendanceHours,
          icon: Assets.icons.clock,
          color: const Color(0xFF496ce5).withOpacity(0.8),
        );
      case StatisticsCardType.attendanceLectures:
        return _CardData(
          title: AppStrings.numberOfAttendanceLectures,
          icon: Assets.icons.clock,
          color: const Color(0xFFfc7cac).withOpacity(0.8),
        );
      case StatisticsCardType.daysToTheFinals:
        return _CardData(
          title: AppStrings.numberOfDaysToTheFinals,
          icon: Assets.icons.callender,
          color: const Color(0xFFa874f3).withOpacity(0.8),
        );
      case StatisticsCardType.downloadedMaterials:
        return _CardData(
          title: AppStrings.numberOfDownloadedMaterials,
          icon: Assets.icons.downloadedFile,
          color: const Color(0xFF1dceb2).withOpacity(0.8),
        );
    }
  }
}

/// The content of a statistics card with all its visual elements.
class _StatisticsCardContent extends StatelessWidget {
  final String title;
  final String value;
  final String icon;
  final Color color;
  final bool isLoading;

  const _StatisticsCardContent({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: AppColors.coloredShadow(color.withOpacity(0.25)),
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          _buildBackground(),
          _buildTopCircle(context),
          _buildBottomCircle(context),
          _buildIcon(context),
          _buildContent(context),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      width: double.infinity,
      padding: REdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16.r),
      ),
    );
  }

  Widget _buildTopCircle(BuildContext context) {
    return Positioned(
      top: -70.h,
      left: context.isEnglish ? -40.w : null,
      right: context.isEnglish ? null : -40.w,
      child: Container(
        height: 180.h,
        width: 180.w,
        decoration: BoxDecoration(
          color: color.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildBottomCircle(BuildContext context) {
    return Positioned(
      bottom: -25.h,
      left: context.isEnglish ? 0 : -50.w,
      right: context.isEnglish ? -50.w : 0,
      child: Container(
        height: 60.h,
        width: 60.w,
        decoration: BoxDecoration(
          color: color.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    return Positioned(
      top: 15.h,
      left: context.isEnglish ? 10.w : null,
      right: context.isEnglish ? null : 10.w,
      child: Container(
        height: 34.h,
        width: 34.w,
        padding: REdgeInsets.all(7.r),
        decoration: BoxDecoration(
          color: context.backgroundColor.withOpacity(0.85),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: getColoredSvgPicture(
            assetName: icon,
            color: color,
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Positioned(
      bottom: 20.h,
      left: context.isEnglish ? 10.w : 0,
      right: context.isEnglish ? 0 : 10.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            textAlign: TextAlign.start,
            style: context.textTheme.bodySmall!
                .withColor(context.backgroundColor)
                .withWeight(FontWeight.w600),
          ),
          8.verticalSpace,
          isLoading
              ? DotLoadingIndicator(
                  color: context.backgroundColor,
                  height: 22.h,
                  mainAxisAlignment: MainAxisAlignment.start,
                )
              : Text(
                  "  $value",
                  style: context.textTheme.titleMedium!.copyWith(
                    color: context.backgroundColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ],
      ),
    );
  }
}

/// Data class to hold card-specific information
class _CardData {
  final String title;
  final String icon;
  final Color color;

  const _CardData({
    required this.title,
    required this.icon,
    required this.color,
  });
}
