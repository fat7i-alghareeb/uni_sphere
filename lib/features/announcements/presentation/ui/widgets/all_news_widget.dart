import 'package:test/core/result_builder/result_builder.dart';
import 'package:test/features/announcements/domain/entities/news_entity.dart';
import 'package:test/features/announcements/presentation/state/bloc/announcement_bloc.dart';
import 'package:test/shared/widgets/custom_shimmer.dart';
import 'package:test/core/styles/colors.dart';
import 'package:test/shared/widgets/custom_network_image.dart';
import '../../../../../core/injection/injection.dart';
import '../../../../../shared/imports/imports.dart';

class AllNewsWidget extends StatefulWidget {
  const AllNewsWidget({super.key});

  @override
  State<AllNewsWidget> createState() => _AllNewsWidgetState();
}

class _AllNewsWidgetState extends State<AllNewsWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late List<Animation<double>> _animations = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    getIt<AnnouncementBloc>().add(
      GetAnnouncementEvent(),
    );
  }

  void _initializeAnimations(int itemCount) {
    try {
      _controller.reset();
      _animations = List.generate(
        itemCount,
        (index) => Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(
              index * (0.5 / itemCount),
              (index * (0.5 / itemCount)) + 0.5,
              curve: Curves.easeOut,
            ),
          ),
        ),
      );

      _controller.forward();
    } catch (e) {
      debugPrint('Error initializing animations: $e');
      _animations = List.generate(
        itemCount,
        (index) => const AlwaysStoppedAnimation(1.0),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnnouncementBloc, AnnouncementState>(
      builder: (context, state) => ResultBuilder<List<NewsEntity>>(
        loading: () => _buildLoadingShimmer(),
        success: (data) {
          _initializeAnimations(data.length);
          return Stack(
            children: [
              _buildShimmerList(data.length),
              _buildAnimatedNewsList(data),
            ],
          );
        },
        result: state.result,
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return ListView.builder(
      padding: REdgeInsets.only(
        left: AppConstants.horizontalScreensPadding,
        right: AppConstants.horizontalScreensPadding,
        bottom: 100.h,
      ),
      itemBuilder: (context, index) => Container(
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
              child: CustomShimmerWidget(
                height: 180.h,
                width: double.infinity,
                borderRadius: 22,
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    REdgeInsets.symmetric(horizontal: 22.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomShimmerWidget(
                      height: 12.h,
                      width: 100.w,
                      borderRadius: 8,
                    ),
                    8.verticalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomShimmerWidget(
                            height: 16.h,
                            width: double.infinity,
                            borderRadius: 8,
                          ),
                          5.verticalSpace,
                          CustomShimmerWidget(
                            height: 16.h,
                            width: double.infinity,
                            borderRadius: 8,
                          ),
                          5.verticalSpace,
                          CustomShimmerWidget(
                            height: 16.h,
                            width: double.infinity,
                            borderRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      itemCount: 10,
    );
  }

  Widget _buildShimmerList(int itemCount) {
    try {
      return ListView.builder(
        padding: REdgeInsets.only(
          left: AppConstants.horizontalScreensPadding,
          right: AppConstants.horizontalScreensPadding,
          bottom: 100.h,
        ),
        itemBuilder: (context, index) {
          if (index >= _animations.length) {
            return const SizedBox.shrink();
          }
          return AnimatedBuilder(
            animation: _animations[index],
            builder: (context, child) {
              return Opacity(
                opacity: 1 - _animations[index].value,
                child: child,
              );
            },
            child: _buildShimmerCard(),
          );
        },
        itemCount: itemCount,
      );
    } catch (e) {
      debugPrint('Error building shimmer list: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildAnimatedNewsList(List<NewsEntity> data) {
    try {
      return ListView.builder(
        padding: REdgeInsets.only(
          left: AppConstants.horizontalScreensPadding,
          right: AppConstants.horizontalScreensPadding,
          bottom: 100.h,
        ),
        itemBuilder: (context, index) {
          if (index >= data.length || index >= _animations.length) {
            return const SizedBox.shrink();
          }
          return Container(
            height: 300.h,
            margin: REdgeInsets.only(bottom: 22.h),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: context.cardColor,
              borderRadius: BorderRadius.circular(22.r),
              boxShadow: AppColors.primaryShadow(context),
            ),
            child: Stack(
              children: [
                // Shimmer content
                AnimatedBuilder(
                  animation: _animations[index],
                  builder: (context, child) {
                    return Opacity(
                      opacity: 1 - _animations[index].value,
                      child: child,
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: AppColors.primaryShadow(context),
                        ),
                        child: CustomShimmerWidget(
                          height: 180.h,
                          width: double.infinity,
                          borderRadius: 22,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: REdgeInsets.symmetric(
                              horizontal: 22.w, vertical: 12.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomShimmerWidget(
                                height: 12.h,
                                width: 100.w,
                                borderRadius: 8,
                              ),
                              8.verticalSpace,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomShimmerWidget(
                                      height: 16.h,
                                      width: double.infinity,
                                      borderRadius: 8,
                                    ),
                                    5.verticalSpace,
                                    CustomShimmerWidget(
                                      height: 16.h,
                                      width: double.infinity,
                                      borderRadius: 8,
                                    ),
                                    5.verticalSpace,
                                    CustomShimmerWidget(
                                      height: 16.h,
                                      width: double.infinity,
                                      borderRadius: 8,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // Actual content
                AnimatedBuilder(
                  animation: _animations[index],
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, -20 * (1 - _animations[index].value)),
                      child: Opacity(
                        opacity: _animations[index].value,
                        child: child,
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: AppColors.primaryShadow(context),
                        ),
                        child: CustomNetworkImage(
                          imageUrl: data[index].image?[0] ?? '',
                          height: 180.h,
                          width: double.infinity,
                          borderRadius: 22,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: REdgeInsets.symmetric(
                              horizontal: 22.w, vertical: 12.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data[index].createdAt,
                                style: context.textTheme.labelMedium?.copyWith(
                                  color: context.greyColor,
                                ),
                              ),
                              5.verticalSpace,
                              Expanded(
                                child: Text(
                                  data[index].description,
                                  style: context.textTheme.labelLarge!.copyWith(
                                    wordSpacing: 1.8,
                                    height: 1.5,
                                    letterSpacing: 0.4,
                                    fontWeight: FontWeight.w900,
                                    color: context.onBackgroundColor
                                        .withValues(alpha: 0.95),
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
                ),
              ],
            ),
          );
        },
        itemCount: data.length,
      );
    } catch (e) {
      debugPrint('Error building animated news list: $e');
      return const SizedBox.shrink();
    }
  }

  Widget _buildShimmerCard() {
    try {
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
              child: CustomShimmerWidget(
                height: 180.h,
                width: double.infinity,
                borderRadius: 22,
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    REdgeInsets.symmetric(horizontal: 22.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomShimmerWidget(
                      height: 12.h,
                      width: 100.w,
                      borderRadius: 8,
                    ),
                    8.verticalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomShimmerWidget(
                            height: 16.h,
                            width: double.infinity,
                            borderRadius: 8,
                          ),
                          5.verticalSpace,
                          CustomShimmerWidget(
                            height: 16.h,
                            width: double.infinity,
                            borderRadius: 8,
                          ),
                          5.verticalSpace,
                          CustomShimmerWidget(
                            height: 16.h,
                            width: double.infinity,
                            borderRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    } catch (e) {
      debugPrint('Error building shimmer card: $e');
      return const SizedBox.shrink();
    }
  }
}
