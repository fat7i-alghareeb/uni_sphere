import 'package:test/core/result_builder/result.dart';
import 'package:test/core/styles/app_text_theme.dart';
import 'package:test/shared/utils/helper/get_colored_svg_picture.dart';
import 'package:test/shared/widgets/dot_loading_indicator.dart';

import '../../../../../common/constant/app_strings.dart';
import '../../../../../shared/imports/imports.dart';
import '../../../domain/entities/statistics_entity.dart';
import '../../state/bloc/home_bloc.dart';

class StatisticsWidget extends StatefulWidget {
  const StatisticsWidget({super.key});

  @override
  State<StatisticsWidget> createState() => _StatisticsWidgetState();
}

class _StatisticsWidgetState extends State<StatisticsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(
          horizontal: AppConstants.horizontalScreensPadding),
      child: SizedBox(
        height: 320.h,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: _buildStatisticCard(
                          type: StatisticsCardType.attendanceHours)),
                  26.horizontalSpace,
                  Expanded(
                      child: _buildStatisticCard(
                          type: StatisticsCardType.attendanceLectures)),
                ],
              ),
            ),
            15.verticalSpace,
            Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: _buildStatisticCard(
                          type: StatisticsCardType.daysToTheFinals)),
                  26.horizontalSpace,
                  Expanded(
                      child: _buildStatisticCard(
                          type: StatisticsCardType.downloadedMaterials)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticCard({
    required StatisticsCardType type,
  }) {
    late final String title;
    String value = "";
    late final String icon;
    late final Color color;
    switch (type) {
      case StatisticsCardType.attendanceHours:
        title = AppStrings.numberOfAttendanceHours;
        icon = Assets.icons.clock;

        color = const Color(0xFF496ce5).withOpacity(0.8);
        break;
      case StatisticsCardType.attendanceLectures:
        title = AppStrings.numberOfAttendanceLectures;
        icon = Assets.icons.clock;
        color = const Color(0xFFfc7cac).withOpacity(0.8);
        break;
      case StatisticsCardType.daysToTheFinals:
        title = AppStrings.numberOfDaysToTheFinals;
        icon = Assets.icons.callender;
        color = const Color(0xFFa874f3).withOpacity(0.8);
        break;
      case StatisticsCardType.downloadedMaterials:
        title = AppStrings.numberOfDownloadedMaterials;
        icon = Assets.icons.downloadedFile;
        color = const Color(0xFF1dceb2).withOpacity(0.8);
        break;
    }
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.result.isLoaded()) {
          final statistics = state.result.getDataWhenSuccess()?.statistics;
          switch (type) {
            case StatisticsCardType.attendanceHours:
              value = statistics?.numberOfAttendanceHours.toString() ?? '';
              break;
            case StatisticsCardType.attendanceLectures:
              value = statistics?.numberOfAttendanceLectures.toString() ?? '';
              break;
            case StatisticsCardType.daysToTheFinals:
              value = statistics?.numberOfDaysToTheFinals.toString() ?? '';
              break;
            case StatisticsCardType.downloadedMaterials:
              value = statistics?.numberOfDownloadedMaterials.toString() ?? '';
              break;
          }
        }
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              Container(
                width: double.infinity,
                padding: REdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              Positioned(
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
              ),
              Positioned(
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
              ),
              Positioned(
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
              ),
              Positioned(
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
                          .withColor(
                            context.backgroundColor,
                          )
                          .withWeight(FontWeight.w600),
                    ),
                    8.verticalSpace,
                    state.result.isLoading()
                        ? DotLoadingIndicator(
                            color: context.backgroundColor,
                            height: 22.h,
                            // mainAxisAlignment: MainAxisAlignment.start,
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
              ),
            ],
          ),
        );
      },
    );
  }
}
